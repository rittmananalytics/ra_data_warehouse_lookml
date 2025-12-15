# Engagement Renewal Analysis View
# This derived table calculates renewal opportunities, renewals, churns, and reactivations
# Based on 60-day renewal window logic

view: engagement_renewal_analysis {
  derived_table: {
    sql:
      WITH engagement_sequence AS (
        -- Get all engagements with their company, start and end dates
        SELECT
          c.company_name,
          c.company_pk,
          e.project_engagement_pk AS engagement_pk,
          e.deal_name AS engagement_name,
          TIMESTAMP(e.engagement_start_ts) AS engagement_start_date,
          TIMESTAMP(e.engagement_end_ts) AS engagement_end_date,
          -- Get the next engagement start date for the same company
          LEAD(TIMESTAMP(e.engagement_start_ts)) OVER (
            PARTITION BY c.company_pk 
            ORDER BY TIMESTAMP(e.engagement_end_ts), TIMESTAMP(e.engagement_start_ts)
          ) AS next_engagement_start_date,
          -- Get the previous engagement end date for the same company
          LAG(TIMESTAMP(e.engagement_end_ts)) OVER (
            PARTITION BY c.company_pk 
            ORDER BY TIMESTAMP(e.engagement_end_ts), TIMESTAMP(e.engagement_start_ts)
          ) AS previous_engagement_end_date
        FROM `analytics.companies_dim` AS c
        LEFT JOIN (
          SELECT project_engagement_pk, engagement_code, company_fk, engagement_start_ts, engagement_end_ts, deal_id, deal_amount, deal_hourly_rate, deal_description, deal_name, deal_type, deal_partner_referral, deal_source, deal_days_to_close, deal_created_ts, dt_entered_3_sow_drafted, dt_entered_5_customer_agreed_sow, dt_entered_7_sow_customer_docusigned, deal_closed_ts, projects 
          FROM `analytics.timesheet_project_engagements_dim`
          GROUP BY ALL
        ) AS e
          ON c.company_pk = e.company_fk
        WHERE e.engagement_end_ts IS NOT NULL
          AND e.engagement_start_ts IS NOT NULL
      ),
      
      engagement_gaps AS (
        -- Calculate days between engagements
        SELECT
          *,
          DATE_DIFF(DATE(next_engagement_start_date), DATE(engagement_end_date), DAY) AS days_to_next_engagement,
          DATE_DIFF(DATE(engagement_start_date), DATE(previous_engagement_end_date), DAY) AS days_from_previous_engagement
        FROM engagement_sequence
      ),
      
      engagement_status AS (
        -- Determine renewal/churn/reactivation status
        SELECT
          *,
          -- Renewal: next engagement starts within 60 days (or overlaps)
          CASE
            WHEN next_engagement_start_date IS NOT NULL 
              AND days_to_next_engagement <= 60 THEN TRUE
            ELSE FALSE
          END AS is_renewed,
          
          -- Churn: no next engagement OR next engagement is > 60 days away
          CASE
            WHEN next_engagement_start_date IS NULL THEN TRUE
            WHEN days_to_next_engagement > 60 THEN TRUE
            ELSE FALSE
          END AS is_churned,
          
          -- Reactivation: this engagement started > 60 days after previous ended
          CASE
            WHEN previous_engagement_end_date IS NOT NULL 
              AND days_from_previous_engagement > 60 THEN TRUE
            ELSE FALSE
          END AS is_reactivation,
          
          -- First churn date (when this specific engagement created a churn)
          CASE
            WHEN next_engagement_start_date IS NULL 
              OR days_to_next_engagement > 60
            THEN engagement_end_date
            ELSE NULL
          END AS first_churn_date
          
        FROM engagement_gaps
      )
      
      SELECT
        company_name,
        company_pk,
        engagement_pk,
        engagement_name,
        engagement_start_date,
        engagement_end_date,
        next_engagement_start_date,
        previous_engagement_end_date,
        days_to_next_engagement,
        days_from_previous_engagement,
        is_renewed,
        is_churned,
        is_reactivation,
        first_churn_date,
        
        -- Extract quarter and year for grouping
        EXTRACT(QUARTER FROM engagement_end_date) AS end_quarter_num,
        EXTRACT(YEAR FROM engagement_end_date) AS end_year,
        FORMAT_DATE('%Y-Q%Q', DATE(engagement_end_date)) AS end_quarter_label,
        
        CASE WHEN first_churn_date IS NOT NULL THEN
          EXTRACT(QUARTER FROM first_churn_date)
        END AS churn_quarter_num,
        
        CASE WHEN first_churn_date IS NOT NULL THEN
          EXTRACT(YEAR FROM first_churn_date)
        END AS churn_year,
        
        CASE WHEN first_churn_date IS NOT NULL THEN
          FORMAT_DATE('%Y-Q%Q', DATE(first_churn_date))
        END AS churn_quarter_label,
        
        CASE WHEN is_reactivation THEN
          EXTRACT(QUARTER FROM engagement_start_date)
        END AS reactivation_quarter_num,
        
        CASE WHEN is_reactivation THEN
          EXTRACT(YEAR FROM engagement_start_date)
        END AS reactivation_year,
        
        CASE WHEN is_reactivation THEN
          FORMAT_DATE('%Y-Q%Q', DATE(engagement_start_date))
        END AS reactivation_quarter_label
        
      FROM engagement_status
    ;;
    
    datagroup_trigger: daily_refresh
  }
  
  # Primary Key
  dimension: engagement_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.engagement_pk ;;
  }
  
  # Company Information
  dimension: company_pk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_pk ;;
  }
  
  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
    link: {
      label: "View Company Details"
      url: "/explore/analytics/companies_dim?fields=companies_dim.company_name&f[companies_dim.company_name]={{ value | encode_uri }}"
    }
  }
  
  dimension: engagement_name {
    type: string
    sql: ${TABLE}.engagement_name ;;
  }
  
  # Dates
  dimension_group: engagement_start {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.engagement_start_date ;;
  }
  
  dimension_group: engagement_end {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.engagement_end_date ;;
  }
  
  dimension_group: next_engagement_start {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.next_engagement_start_date ;;
  }
  
  dimension_group: previous_engagement_end {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.previous_engagement_end_date ;;
  }
  
  dimension_group: first_churn {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.first_churn_date ;;
  }
  
  # Gap Analysis
  dimension: days_to_next_engagement {
    type: number
    sql: ${TABLE}.days_to_next_engagement ;;
    description: "Number of days between this engagement ending and the next one starting"
  }
  
  dimension: days_from_previous_engagement {
    type: number
    sql: ${TABLE}.days_from_previous_engagement ;;
    description: "Number of days between the previous engagement ending and this one starting"
  }
  
  dimension: renewal_window_category {
    type: string
    sql: CASE
      WHEN ${TABLE}.days_to_next_engagement IS NULL THEN 'No Follow-up'
      WHEN ${TABLE}.days_to_next_engagement <= 0 THEN 'Overlap'
      WHEN ${TABLE}.days_to_next_engagement <= 30 THEN '1-30 Days'
      WHEN ${TABLE}.days_to_next_engagement <= 60 THEN '31-60 Days'
      WHEN ${TABLE}.days_to_next_engagement <= 90 THEN '61-90 Days'
      ELSE '90+ Days'
    END ;;
    order_by_field: renewal_window_category_sort
  }
  
  dimension: renewal_window_category_sort {
    hidden: yes
    type: number
    sql: CASE
      WHEN ${TABLE}.days_to_next_engagement IS NULL THEN 6
      WHEN ${TABLE}.days_to_next_engagement <= 0 THEN 1
      WHEN ${TABLE}.days_to_next_engagement <= 30 THEN 2
      WHEN ${TABLE}.days_to_next_engagement <= 60 THEN 3
      WHEN ${TABLE}.days_to_next_engagement <= 90 THEN 4
      ELSE 5
    END ;;
  }
  
  # Status Flags
  dimension: is_renewed {
    type: yesno
    sql: ${TABLE}.is_renewed ;;
    description: "True if next engagement starts within 60 days of this one ending"
  }
  
  dimension: is_churned {
    type: yesno
    sql: ${TABLE}.is_churned ;;
    description: "True if no next engagement OR next engagement starts > 60 days later"
  }
  
  dimension: is_reactivation {
    type: yesno
    sql: ${TABLE}.is_reactivation ;;
    description: "True if this engagement started > 60 days after previous one ended"
  }
  
  dimension: engagement_outcome {
    type: string
    sql: CASE
      WHEN ${TABLE}.is_renewed THEN 'Renewed'
      WHEN ${TABLE}.is_churned THEN 'Churned'
      ELSE 'Unknown'
    END ;;
  }
  
  # Quarter Labels for Grouping
  dimension: end_quarter_label {
    type: string
    sql: ${TABLE}.end_quarter_label ;;
    label: "Engagement End Quarter"
    description: "Quarter when this engagement ended (creates renewal opportunity)"
  }
  
  dimension: churn_quarter_label {
    type: string
    sql: ${TABLE}.churn_quarter_label ;;
    label: "Churn Quarter"
    description: "Quarter when this engagement created a churn"
  }
  
  dimension: reactivation_quarter_label {
    type: string
    sql: ${TABLE}.reactivation_quarter_label ;;
    label: "Reactivation Quarter"
    description: "Quarter when this engagement was a reactivation"
  }
  
  # ============================================
  # MEASURES - The Key Metrics
  # ============================================
  
  # 1. Renewal Opportunities
  measure: renewal_opportunities {
    type: count
    label: "Renewal Opportunities"
    description: "Total number of engagements that ended (each creates an opportunity to renew)"
    drill_fields: [detail*]
  }
  
  # 2. Renewals
  measure: renewals {
    type: count
    filters: [is_renewed: "yes"]
    label: "Renewals"
    description: "Number of engagements that were successfully renewed (next engagement within 60 days)"
    drill_fields: [detail*]
  }
  
  # 3. Churns (New in Quarter)
  measure: new_churns {
    type: count
    filters: [is_churned: "yes"]
    label: "New Churns"
    description: "Number of engagements that churned (no follow-up within 60 days)"
    drill_fields: [detail*]
  }
  
  # 4. Renewal Rate
  measure: renewal_rate {
    type: number
    sql: SAFE_DIVIDE(${renewals}, ${renewal_opportunities}) ;;
    value_format_name: percent_1
    label: "Renewal Rate"
    description: "Percentage of renewal opportunities that converted to renewals (Renewals ÷ Opportunities)"
    drill_fields: [detail*]
  }
  
  # 5. Unique Companies with Renewals
  measure: unique_companies_renewed {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [is_renewed: "yes"]
    label: "Unique Companies Renewed"
    description: "Number of unique companies that had at least one renewal"
  }
  
  # 6. Unique Companies Churned
  measure: unique_companies_churned {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [is_churned: "yes"]
    label: "Unique Companies Churned"
    description: "Number of unique companies that churned"
  }
  
  # 7. Reactivations
  measure: reactivations {
    type: count
    filters: [is_reactivation: "yes"]
    label: "Reactivations"
    description: "Number of engagements that were reactivations (started > 60 days after previous ended)"
    drill_fields: [detail*]
  }
  
  # 8. Average Days to Next Engagement
  measure: avg_days_to_next_engagement {
    type: average
    sql: ${days_to_next_engagement} ;;
    value_format_name: decimal_1
    label: "Avg Days to Next Engagement"
    description: "Average number of days between engagement end and next engagement start"
  }
  
  # Drill Fields
  set: detail {
    fields: [
      company_name,
      engagement_name,
      engagement_end_date,
      next_engagement_start_date,
      days_to_next_engagement,
      engagement_outcome,
      is_reactivation
    ]
  }
}
