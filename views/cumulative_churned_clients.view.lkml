# Cumulative Churned Clients Analysis
# Tracks which clients are in "churned" status each quarter
# Once churned, they remain in this pool until reactivated

view: cumulative_churned_clients {
  derived_table: {
    sql:
      WITH all_quarters AS (
        -- Generate all quarters from first engagement to current
        SELECT DISTINCT
          FORMAT_DATE('%Y-Q%Q', DATE(engagement_end_date)) AS quarter_label,
          EXTRACT(YEAR FROM engagement_end_date) AS year,
          EXTRACT(QUARTER FROM engagement_end_date) AS quarter_num,
          engagement_end_date
        FROM (
          SELECT project_engagement_pk, engagement_code, company_fk, engagement_start_ts, engagement_end_ts, deal_id, deal_amount, deal_hourly_rate, deal_description, deal_name, deal_type, deal_partner_referral, deal_source, deal_days_to_close, deal_created_ts, dt_entered_3_sow_drafted, dt_entered_5_customer_agreed_sow, dt_entered_7_sow_customer_docusigned, deal_closed_ts, projects 
          FROM `analytics.timesheet_project_engagements_dim`
          WHERE engagement_end_ts IS NOT NULL
          GROUP BY ALL
        ) sub1
        CROSS JOIN UNNEST([TIMESTAMP(sub1.engagement_end_ts)]) AS engagement_end_date
      ),
      
      company_churn_events AS (
        -- Get first churn date for each company from the renewal analysis
        SELECT
          company_pk,
          company_name,
          MIN(first_churn_date) AS first_churn_date,
          FORMAT_DATE('%Y-Q%Q', DATE(MIN(first_churn_date))) AS first_churn_quarter
        FROM ${engagement_renewal_analysis.SQL_TABLE_NAME}
        WHERE first_churn_date IS NOT NULL
        GROUP BY company_pk, company_name
      ),
      
      company_reactivation_events AS (
        -- Get reactivation dates for churned companies
        SELECT
          company_pk,
          engagement_start_date AS reactivation_date,
          FORMAT_DATE('%Y-Q%Q', DATE(engagement_start_date)) AS reactivation_quarter
        FROM ${engagement_renewal_analysis.SQL_TABLE_NAME}
        WHERE is_reactivation = TRUE
      ),
      
      company_status_by_quarter AS (
        -- For each company and quarter, determine if they're churned
        SELECT
          q.quarter_label,
          q.year,
          q.quarter_num,
          c.company_pk,
          c.company_name,
          c.first_churn_date,
          c.first_churn_quarter,
          r.reactivation_date,
          r.reactivation_quarter,
          -- Churned if: churn date <= quarter end AND (no reactivation OR reactivation > quarter end)
          CASE
            WHEN c.first_churn_date IS NOT NULL
              AND DATE(c.first_churn_date) <= LAST_DAY(DATE(q.engagement_end_date), QUARTER)
              AND (r.reactivation_date IS NULL OR DATE(r.reactivation_date) > LAST_DAY(DATE(q.engagement_end_date), QUARTER))
            THEN TRUE
            ELSE FALSE
          END AS is_churned_in_quarter
        FROM all_quarters q
        CROSS JOIN company_churn_events c
        LEFT JOIN company_reactivation_events r
          ON c.company_pk = r.company_pk
          AND DATE(r.reactivation_date) > DATE(c.first_churn_date)
      )
      
      SELECT
        quarter_label,
        year,
        quarter_num,
        company_pk,
        company_name,
        first_churn_date,
        first_churn_quarter,
        reactivation_date,
        reactivation_quarter,
        is_churned_in_quarter
      FROM company_status_by_quarter
      WHERE is_churned_in_quarter = TRUE
      ORDER BY quarter_label, company_name
    ;;
    
    datagroup_trigger: daily_refresh
  }
  
  # Primary Key
  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.quarter_label, '-', ${TABLE}.company_pk) ;;
  }
  
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
  
  dimension: quarter_label {
    type: string
    sql: ${TABLE}.quarter_label ;;
    label: "Quarter"
    description: "Quarter for which churn status is being tracked"
  }
  
  dimension_group: first_churn {
    type: time
    timeframes: [date, month, quarter, year]
    sql: ${TABLE}.first_churn_date ;;
    description: "When this company first churned"
  }
  
  dimension: first_churn_quarter_label {
    type: string
    sql: ${TABLE}.first_churn_quarter ;;
    label: "First Churn Quarter"
  }
  
  dimension_group: reactivation {
    type: time
    timeframes: [date, month, quarter, year]
    sql: ${TABLE}.reactivation_date ;;
    description: "When this company was reactivated (if applicable)"
  }
  
  dimension: reactivation_quarter_label {
    type: string
    sql: ${TABLE}.reactivation_quarter ;;
    label: "Reactivation Quarter"
  }
  
  dimension: is_churned_in_quarter {
    type: yesno
    sql: ${TABLE}.is_churned_in_quarter ;;
    hidden: yes
  }
  
  # Measures
  measure: cumulative_churned_clients {
    type: count_distinct
    sql: ${company_pk} ;;
    label: "Cumulative Churned Clients"
    description: "Number of unique companies in churned status for this quarter"
    drill_fields: [company_name, first_churn_date, first_churn_quarter_label]
  }
  
  measure: companies_list {
    type: list
    list_field: company_name
    label: "List of Churned Companies"
  }
}
