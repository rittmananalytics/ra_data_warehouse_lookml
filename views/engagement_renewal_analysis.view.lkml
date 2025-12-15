# Engagement Renewal Analysis View
# This derived table calculates renewal opportunities, renewals, churns, and reactivations
# Based on 60-day renewal window logic
# WITH CORRECT REVENUE TRACKING: Retained revenue = NEXT engagement's value
# WITH CORRECT TIMING: Retained revenue attributed to quarter when NEW engagement started

view: engagement_renewal_analysis {
  derived_table: {
    sql:
      WITH engagement_sequence AS (
        -- Get all engagements with their company, start and end dates, AND DEAL AMOUNT
        SELECT
          c.company_name,
          c.company_pk,
          e.project_engagement_pk AS engagement_pk,
          e.deal_name AS engagement_name,
          TIMESTAMP(e.engagement_start_ts) AS engagement_start_date,
          TIMESTAMP(e.engagement_end_ts) AS engagement_end_date,
          e.deal_amount AS engagement_deal_amount_gbp,
          -- Get the next engagement details
          LEAD(TIMESTAMP(e.engagement_start_ts)) OVER (
            PARTITION BY c.company_pk 
            ORDER BY TIMESTAMP(e.engagement_end_ts), TIMESTAMP(e.engagement_start_ts)
          ) AS next_engagement_start_date,
          -- Get the NEXT engagement's revenue (what we actually retained!)
          LEAD(e.deal_amount) OVER (
            PARTITION BY c.company_pk 
            ORDER BY TIMESTAMP(e.engagement_end_ts), TIMESTAMP(e.engagement_start_ts)
          ) AS next_engagement_deal_amount_gbp,
          -- Get the previous engagement end date
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
        -- Calculate days between engagements and days since engagement ended
        SELECT
          *,
          DATE_DIFF(DATE(next_engagement_start_date), DATE(engagement_end_date), DAY) AS days_to_next_engagement,
          DATE_DIFF(DATE(previous_engagement_end_date), DATE(engagement_start_date), DAY) AS days_from_previous_engagement,
          DATE_DIFF(CURRENT_DATE(), DATE(engagement_end_date), DAY) AS days_since_engagement_ended
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
          
          -- Churn: engagement ended 60+ days ago with no renewal
          CASE
            WHEN days_since_engagement_ended > 60 
              AND (next_engagement_start_date IS NULL OR days_to_next_engagement > 60) 
            THEN TRUE
            ELSE FALSE
          END AS is_churned,
          
          -- Reactivation: this engagement started > 60 days after previous ended
          CASE
            WHEN previous_engagement_end_date IS NOT NULL 
              AND days_from_previous_engagement > 60 THEN TRUE
            ELSE FALSE
          END AS is_reactivation,
          
          -- First churn date - only set if actually churned (60+ days elapsed)
          CASE
            WHEN days_since_engagement_ended > 60 
              AND (next_engagement_start_date IS NULL OR days_to_next_engagement > 60)
            THEN TIMESTAMP_ADD(engagement_end_date, INTERVAL 60 DAY)
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
        engagement_deal_amount_gbp,
        next_engagement_deal_amount_gbp,
        next_engagement_start_date,
        previous_engagement_end_date,
        days_to_next_engagement,
        days_from_previous_engagement,
        days_since_engagement_ended,
        is_renewed,
        is_churned,
        is_reactivation,
        first_churn_date,
        
        -- Quarter labels based on ENDING engagement (for opportunity/churn timing)
        EXTRACT(QUARTER FROM engagement_end_date) AS end_quarter_num,
        EXTRACT(YEAR FROM engagement_end_date) AS end_year,
        FORMAT_DATE('%Y-Q%Q', DATE(engagement_end_date)) AS end_quarter_label,
        
        -- ADDED: Quarter labels based on NEXT engagement START (for renewal timing - when won!)
        CASE WHEN next_engagement_start_date IS NOT NULL THEN
          EXTRACT(QUARTER FROM next_engagement_start_date)
        END AS renewal_quarter_num,
        
        CASE WHEN next_engagement_start_date IS NOT NULL THEN
          EXTRACT(YEAR FROM next_engagement_start_date)
        END AS renewal_year,
        
        CASE WHEN next_engagement_start_date IS NOT NULL THEN
          FORMAT_DATE('%Y-Q%Q', DATE(next_engagement_start_date))
        END AS renewal_quarter_label,
        
        -- Churn quarter
        CASE WHEN first_churn_date IS NOT NULL THEN
          EXTRACT(QUARTER FROM first_churn_date)
        END AS churn_quarter_num,
        
        CASE WHEN first_churn_date IS NOT NULL THEN
          EXTRACT(YEAR FROM first_churn_date)
        END AS churn_year,
        
        CASE WHEN first_churn_date IS NOT NULL THEN
          FORMAT_DATE('%Y-Q%Q', DATE(first_churn_date))
        END AS churn_quarter_label,
        
        -- Reactivation quarter
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
  
  # Revenue Dimensions
  dimension: engagement_deal_amount_gbp {
    type: number
    sql: ${TABLE}.engagement_deal_amount_gbp ;;
    value_format_name: gbp
    label: "Engagement Deal Amount (GBP)"
    description: "The GBP value of THIS engagement that ended"
  }
  
  dimension: next_engagement_deal_amount_gbp {
    type: number
    sql: ${TABLE}.next_engagement_deal_amount_gbp ;;
    value_format_name: gbp
    label: "Next Engagement Deal Amount (GBP)"
    description: "The GBP value of the NEXT engagement (retained revenue)"
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
  
  dimension: days_since_engagement_ended {
    type: number
    sql: ${TABLE}.days_since_engagement_ended ;;
    description: "Number of days since this engagement ended (relative to today)"
    label: "Days Since Ended"
  }
  
  # Engagement Status
  dimension: engagement_status {
    type: string
    sql: CASE
      WHEN ${TABLE}.days_since_engagement_ended < 0 THEN 'Active (Not Yet Ended)'
      WHEN ${TABLE}.days_since_engagement_ended BETWEEN 0 AND 60 THEN 'In Renewal Window (0-60 days)'
      WHEN ${TABLE}.is_renewed THEN 'Renewed'
      WHEN ${TABLE}.is_churned THEN 'Churned (60+ days, no renewal)'
      ELSE 'Unknown'
    END ;;
    description: "Current status of the engagement based on end date and renewal outcome"
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
    description: "True if engagement ended 60+ days ago with no follow-up within 60 days"
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
  
  # ADDED: Quarter when renewal was WON (new engagement started)
  dimension: renewal_quarter_label {
    type: string
    sql: ${TABLE}.renewal_quarter_label ;;
    label: "Renewal Won Quarter"
    description: "Quarter when the NEW engagement started (when we won the renewal)"
  }
  
  dimension: churn_quarter_label {
    type: string
    sql: ${TABLE}.churn_quarter_label ;;
    label: "Churn Quarter"
    description: "Quarter when this engagement was confirmed as churned (60 days after end)"
  }
  
  dimension: reactivation_quarter_label {
    type: string
    sql: ${TABLE}.reactivation_quarter_label ;;
    label: "Reactivation Quarter"
    description: "Quarter when this engagement was a reactivation"
  }
  
  # ============================================
  # MEASURES - The Key Metrics (COUNT-BASED)
  # ============================================
  
  measure: renewal_opportunities {
    type: count
    label: "Renewal Opportunities"
    description: "Total number of engagements that ended (each creates an opportunity to renew)"
    drill_fields: [detail*]
  }
  
  measure: renewals {
    type: count
    filters: [is_renewed: "yes"]
    label: "Renewals"
    description: "Number of engagements that were successfully renewed (next engagement within 60 days)"
    drill_fields: [detail*]
  }
  
  measure: new_churns {
    type: count
    filters: [is_churned: "yes"]
    label: "New Churns"
    description: "Number of engagements that churned (no follow-up after 60+ days have elapsed)"
    drill_fields: [detail*]
  }
  
  measure: renewal_rate {
    type: number
    sql: SAFE_DIVIDE(${renewals}, ${renewal_opportunities}) ;;
    value_format_name: percent_1
    label: "Renewal Rate"
    description: "Percentage of renewal opportunities that converted to renewals (Renewals ÷ Opportunities)"
    drill_fields: [detail*]
  }
  
  measure: unique_companies_renewed {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [is_renewed: "yes"]
    label: "Unique Companies Renewed"
    description: "Number of unique companies that had at least one renewal"
  }
  
  measure: unique_companies_churned {
    type: count_distinct
    sql: ${company_pk} ;;
    filters: [is_churned: "yes"]
    label: "Unique Companies Churned"
    description: "Number of unique companies that churned"
  }
  
  measure: reactivations {
    type: count
    filters: [is_reactivation: "yes"]
    label: "Reactivations"
    description: "Number of engagements that were reactivations (started > 60 days after previous ended)"
    drill_fields: [detail*]
  }
  
  measure: avg_days_to_next_engagement {
    type: average
    sql: ${days_to_next_engagement} ;;
    value_format_name: decimal_1
    label: "Avg Days to Next Engagement"
    description: "Average number of days between engagement end and next engagement start"
  }
  
  # ============================================
  # REVENUE-BASED MEASURES (CORRECTED!)
  # ============================================
  
  # Renewal Opportunities Revenue = Revenue that ENDED (at risk)
  measure: renewal_opportunities_revenue_gbp {
    type: sum
    sql: ${engagement_deal_amount_gbp} ;;
    value_format_name: gbp
    label: "Renewal Opportunities Revenue (GBP)"
    description: "Total GBP value of engagements that ended (revenue at risk)"
    drill_fields: [revenue_detail*]
  }
  
  # FIXED: Renewals Revenue = NEXT engagement's revenue (what we secured!)
  # Note: Use renewal_quarter_label to see WHEN this revenue was won
  measure: renewals_revenue_gbp {
    type: sum
    sql: ${next_engagement_deal_amount_gbp} ;;
    filters: [is_renewed: "yes"]
    value_format_name: gbp
    label: "Renewals Revenue (GBP)"
    description: "Total GBP value of NEW engagements secured (retained revenue). Use renewal_quarter_label to see when won."
    drill_fields: [revenue_detail*]
  }
  
  # Churned Revenue = Revenue that ENDED with no follow-up
  measure: churned_revenue_gbp {
    type: sum
    sql: ${engagement_deal_amount_gbp} ;;
    filters: [is_churned: "yes"]
    value_format_name: gbp
    label: "Churned Revenue (GBP)"
    description: "Total GBP value of engagements that churned (lost revenue)"
    drill_fields: [revenue_detail*]
  }
  
  # Reactivations Revenue = Revenue from reactivated engagements
  measure: reactivations_revenue_gbp {
    type: sum
    sql: ${engagement_deal_amount_gbp} ;;
    filters: [is_reactivation: "yes"]
    value_format_name: gbp
    label: "Reactivations Revenue (GBP)"
    description: "Total GBP value of engagements that were reactivations"
    drill_fields: [revenue_detail*]
  }
  
  # Revenue Retention Rate = What we secured / What ended
  measure: revenue_retention_rate {
    type: number
    sql: SAFE_DIVIDE(${renewals_revenue_gbp}, ${renewal_opportunities_revenue_gbp}) ;;
    value_format_name: percent_1
    label: "Revenue Retention Rate"
    description: "Percentage of revenue retained (New Engagement Revenue ÷ Ended Engagement Revenue)"
    drill_fields: [revenue_detail*]
  }
  
  # Average Deal Value for Renewals = Avg of NEXT engagement
  measure: avg_renewal_deal_value_gbp {
    type: average
    sql: ${next_engagement_deal_amount_gbp} ;;
    filters: [is_renewed: "yes"]
    value_format_name: gbp
    label: "Avg Renewal Deal Value (GBP)"
    description: "Average GBP value of NEW engagements secured"
  }
  
  # Average Deal Value for Churns = Avg of ended engagement
  measure: avg_churn_deal_value_gbp {
    type: average
    sql: ${engagement_deal_amount_gbp} ;;
    filters: [is_churned: "yes"]
    value_format_name: gbp
    label: "Avg Churn Deal Value (GBP)"
    description: "Average GBP value of churned engagements"
  }
  
  # Drill Fields
  set: detail {
    fields: [
      company_name,
      engagement_name,
      engagement_end_date,
      days_since_engagement_ended,
      next_engagement_start_date,
      days_to_next_engagement,
      engagement_outcome,
      engagement_status,
      is_reactivation
    ]
  }
  
  # Revenue Drill Fields
  set: revenue_detail {
    fields: [
      company_name,
      engagement_name,
      engagement_deal_amount_gbp,
      next_engagement_deal_amount_gbp,
      engagement_end_date,
      end_quarter_label,
      next_engagement_start_date,
      renewal_quarter_label,
      days_since_engagement_ended,
      days_to_next_engagement,
      engagement_outcome,
      engagement_status,
      is_reactivation
    ]
  }
}
