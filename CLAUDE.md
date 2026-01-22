# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LookML project for Rittman Analytics' data warehouse, connecting to BigQuery via the `ra_dw_prod` connection. It models a professional services consulting business with data spanning sales, project delivery, finance, HR, and marketing.

## Architecture

### Models
- **analytics.model.lkml** - Main model containing all explores and business logic
- **query_insights.model.lkml** - Minimal model (connection only)

### Configuration
- Fiscal month offset: +3 (fiscal year starts in April)
- Week starts: Monday
- Default cache: 1 hour (`analytics_default_datagroup`)
- Daily refresh datagroup available for time-sensitive data

### View Naming Conventions
- `*_dim` - Dimension tables (e.g., `companies_dim`, `contacts_dim`)
- `*_fact` - Fact tables (e.g., `deals_fact`, `timesheets_fact`)
- `*_xa` - Cross-reference/association tables
- Views reference tables via user attribute: `{{ _user_attributes['dataset'] }}.table_name`

### Directory Structure
- `/views/` - Main view files (flat structure)
- `/views/content_analytics/` - Content and web analytics views
- `/views/pdd/` - Product/domain-specific views (aggregates, dimensions, facts subdirectories)
- `/dashboards/` - LookML dashboards
- `/models/` - Model files

### Key Explores (in analytics model)
- **companies_dim** ("Business Operations") - Main operational explore joining companies to engagements, deals, projects, timesheets, invoices, contacts, NPS surveys
- **web_sessions_fact** ("Web Analytics") - Website traffic and visitor journeys
- **contact_utilization_fact** ("Utilization") - Team member utilization reporting
- **project_attribution** - Revenue attribution to team members
- **chart_of_accounts_dim** ("Financials") - General ledger and P&L

### Data Domains
- **CRM/Sales**: Companies, contacts, deals (from HubSpot)
- **Project Delivery**: Engagements (SoWs), timesheets, delivery tasks (Harvest, Jira)
- **Finance**: Invoices, payments, recognized revenue, P&L, bank transactions (Xero)
- **HR**: Utilization, PTO, certifications
- **Marketing**: Email sends, web sessions, content interactions

### Security
- Access grants control sensitive data (e.g., `can_view_company_bio` for company descriptions)
- User attribute `groups` controls access levels

## LookML Patterns Used

### Dynamic Labels
Group labels often use Liquid templating:
```
group_label: "{{ _view._name | replace: '_', ' ' | replace: 'fact', '' | capitalize }}"
```

### Nested Arrays (BigQuery)
UNNEST patterns for array fields:
```
sql: LEFT JOIN UNNEST(${table.array_field}) as unnested_alias ;;
```

### Currency Conversion
GBP conversion applied inline with hardcoded rates (USD: 0.78, CAD: 0.59, EUR: 0.87)

## Manifest Features

The project includes:
- Custom visualizations (`looker_gemini_insight`, `ra-html3`)
- Explore Assistant v2 application (uses `bundle.js`)
