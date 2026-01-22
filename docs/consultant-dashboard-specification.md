# Consultant Performance Dashboard - LookML Specification

## Dashboard Overview

**Dashboard Name:** Consultant Performance  
**Purpose:** Provide individual consultant-level revenue attribution analysis, comparing personal performance against team benchmarks and breaking down revenue contribution by project and client.

**Primary Use Cases:**
- Individual performance reviews
- Resource allocation decisions
- Identifying top-performing consultants
- Understanding revenue concentration by project

---

## Dashboard Filters

### Filter 1: Consultant Selector
- **Field:** `consultant.id`
- **Type:** Single-value dropdown
- **Required:** Yes
- **Default:** First consultant alphabetically
- **Behavior:** All visualizations update to show selected consultant's data

### Filter 2: Year
- **Field:** `revenue.year`
- **Type:** Multi-value checkbox
- **Required:** No
- **Default:** Current year
- **Behavior:** Filters all time-based calculations

---

## Dashboard Layout

The dashboard follows a top-to-bottom flow with the following sections:

1. **Consultant Profile Header** (full width)
2. **KPI Cards Row** (4 cards, equal width)
3. **Charts Row** (2 charts, 50% width each)
4. **Detail Table** (full width)

---

## Visualization Specifications

### 1. Consultant Profile Header

**Type:** Custom info tile  
**Position:** Top of dashboard, full width

**Data Elements:**
| Element | Field | Format |
|---------|-------|--------|
| Avatar | `consultant.initials` | Two-letter circular badge |
| Name | `consultant.name` | Display as heading |
| Role | `consultant.role` | Subtitle text |
| Department | `consultant.department` | Subtitle text, after separator |
| Team Rank | Calculated rank by `total_revenue` | Display as "#N" |

**Calculation - Team Rank:**
```
RANK() OVER (ORDER BY SUM(revenue.amount) DESC)
WHERE consultant.id = selected_consultant
```

---

### 2. Total Revenue KPI

**Type:** Single value tile  
**Position:** KPI row, position 1 of 4

**Measure:** `SUM(revenue.amount)`  
**Filters:** Selected consultant, selected year(s)  
**Format:** Currency with K/M suffix  
**Sublabel:** "All time" or dynamic based on year filter

---

### 3. Monthly Average KPI

**Type:** Single value tile with comparison  
**Position:** KPI row, position 2 of 4

**Primary Measure:** `AVG(monthly_revenue)`  
**Comparison Measure:** Percentage vs team average  
**Format:** Currency with K/M suffix  
**Trend Indicator:** Show up/down arrow with percentage

**Calculation - Monthly Average:**
```
SUM(revenue.amount) / COUNT(DISTINCT revenue.month)
WHERE consultant.id = selected_consultant
```

**Calculation - vs Team Average:**
```
((consultant_avg - team_avg) / team_avg) * 100
```

---

### 4. Active Projects KPI

**Type:** Single value tile  
**Position:** KPI row, position 3 of 4

**Measure:** `COUNT(DISTINCT project.id)`  
**Filters:** 
- Selected consultant
- `project.status = 'active'`

**Format:** Integer  
**Sublabel:** "Currently assigned"

---

### 5. Best Month KPI

**Type:** Single value tile  
**Position:** KPI row, position 4 of 4

**Measure:** `MAX(monthly_revenue)`  
**Format:** Currency with K/M suffix  
**Sublabel:** Month name when maximum occurred (e.g., "Mar 2025")

**Calculation:**
```
SELECT month, SUM(revenue.amount) as monthly_revenue
WHERE consultant.id = selected_consultant
GROUP BY month
ORDER BY monthly_revenue DESC
LIMIT 1
```

---

### 6. Monthly Revenue Trend

**Type:** Line chart  
**Position:** Charts row, left (50% width)

**Title:** Monthly Revenue Trend  
**Subtitle:** Consultant revenue vs team average

**X-Axis:** `revenue.month` (formatted as "Jan", "Feb", etc.)  
**Y-Axis:** Revenue amount (currency format)

**Series:**
| Series Name | Measure | Line Style |
|-------------|---------|------------|
| [Consultant Name] | `SUM(revenue.amount)` for selected consultant | Solid, primary color |
| Team Average | `AVG(SUM(revenue.amount))` across other consultants | Solid, muted color |

**Calculation - Team Average by Month:**
```
SELECT 
  month,
  AVG(consultant_monthly_total) as team_avg
FROM (
  SELECT 
    consultant_id,
    month,
    SUM(revenue.amount) as consultant_monthly_total
  WHERE consultant_id != selected_consultant
  GROUP BY consultant_id, month
)
GROUP BY month
```

**Interactivity:**
- Hover tooltip showing exact values for both series
- Click to drill to monthly detail

---

### 7. Revenue by Project

**Type:** Horizontal bar chart  
**Position:** Charts row, right (50% width)

**Title:** Revenue by Project  
**Subtitle:** Total revenue contribution by project

**Y-Axis:** `project.name` (truncate at 20 characters with ellipsis)  
**X-Axis:** Revenue amount (currency format)

**Measure:** `SUM(revenue.amount)`  
**Dimension:** `project.name`  
**Filters:** Selected consultant  
**Sort:** Descending by revenue  
**Limit:** Top 10 projects

**Interactivity:**
- Click bar to drill to project detail
- Hover tooltip with full project name and exact revenue

---

### 8. Project Revenue Breakdown Table

**Type:** Data table  
**Position:** Below charts row, full width

**Title:** Project Revenue Breakdown  
**Subtitle:** Detailed revenue by project and client

**Columns:**

| Column | Field | Alignment | Format |
|--------|-------|-----------|--------|
| Project | `project.name` | Left | Text |
| Client | `client.name` | Left | Text, muted color |
| Status | `project.status` | Left | Badge/pill format |
| Total Revenue | `SUM(revenue.amount)` | Right | Currency, success color |
| % of Total | Calculated | Right | Percentage, muted color |

**Status Badge Styling:**
- `active`: Success/green background
- `completed`: Muted/gray background  
- `on-hold`: Warning/amber background

**Calculation - % of Total:**
```
(project_revenue / consultant_total_revenue) * 100
```

**Sort:** Descending by Total Revenue  
**Row Animation:** Staggered fade-in on load

**Interactivity:**
- Row click to drill to project detail view
- Column headers sortable

---

## Data Model Requirements

### Required Explores

```lookml
explore: revenue_attribution {
  join: consultant {
    type: left_outer
    relationship: many_to_one
    sql_on: ${revenue_attribution.consultant_id} = ${consultant.id} ;;
  }
  
  join: project {
    type: left_outer
    relationship: many_to_one
    sql_on: ${revenue_attribution.project_id} = ${project.id} ;;
  }
  
  join: client {
    type: left_outer
    relationship: many_to_one
    sql_on: ${project.client_id} = ${client.id} ;;
  }
}
```

### Required Views

1. **consultant** - Consultant dimension table
2. **project** - Project dimension table with status
3. **client** - Client dimension table
4. **revenue_attribution** - Fact table with monthly revenue by consultant/project

---

## Performance Considerations

- Pre-aggregate monthly totals for faster chart rendering
- Index on `consultant_id`, `project_id`, `month` columns
- Consider PDT for team average calculations
- Limit project bar chart to top 10 for readability

---

## Access Requirements

- Dashboard should be filterable by consultant
- Users should only see consultants within their department (optional RLS)
- Export to PDF/CSV enabled for all visualizations
