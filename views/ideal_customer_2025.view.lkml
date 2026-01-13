view: ideal_customer_2025 {
  sql_table_name: `ra-development.analytics_seed.ideal_customer_2025` ;;

  dimension: appeal_of_ra_to_buyer {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Appeal_of_RA_to_Buyer ;;
  }
  dimension: average_monthly_revenue_gbp {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Average_Monthly_Revenue_GBP ;;
  }
  dimension: average_nps_score {
    group_label: "Ideal Customer Segmentation"

    type: number
    sql: ${TABLE}.Average_Nps_Score ;;
  }
  dimension: avg__hourly_rate {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Avg__Hourly_Rate ;;
  }
  dimension: bi_tool {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.BI_Tool ;;
  }
  dimension: buyer_challenge {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Buyer_Challenge ;;
  }
  dimension: buyer_data_maturity {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Buyer_Data_Maturity ;;
  }
  dimension: buyer_requirement {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Buyer_Requirement ;;
  }
  dimension: buyer_role {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Buyer_Role ;;
  }
  dimension: churn_reason {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Churn_Reason ;;
  }
  dimension: churned_year {
    group_label: "Ideal Customer Segmentation"

    type: number
    sql: ${TABLE}.Churned ;;
  }
  dimension: cohort_year {
    group_label: "Ideal Customer Segmentation"


    type: number
    sql: ${TABLE}.Cohort ;;
  }
  dimension: company_name {
    hidden: yes
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Company_Name ;;
  }
  dimension: database {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Database ;;
  }
  dimension: department {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Department ;;
  }
  dimension: digital_native_ {
    group_label: "Ideal Customer Segmentation"

    type: yesno
    sql: ${TABLE}.Digital_Native_ ;;
  }
  dimension: expectations_alignment {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Expectations_Alignment ;;
  }
  dimension: fee_structure {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Fee_Structure ;;
  }
  dimension: grouping {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.`Grouping` ;;
  }
  dimension: is_data_analyst_available {
    group_label: "Ideal Customer Segmentation"

    type: yesno
    sql: ${TABLE}.is_Data_Analyst_Available ;;
  }
  dimension: is_handover_planned {
    group_label: "Ideal Customer Segmentation"

    type: yesno
    sql: ${TABLE}.Is_Handover_Planned ;;
  }
  dimension: is_icp {
    group_label: "Ideal Customer Segmentation"

    type: yesno
    sql: ${TABLE}.Is_ICP_ ;;
  }
  dimension: lead_pathway {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Lead_Pathway ;;
  }
  dimension: lead_pathway_source {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Lead_Pathway_Source ;;
  }
  dimension: lead_technology {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Lead_Technology ;;
  }
  dimension: market {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Market ;;
  }
  dimension: months_billed {
    group_label: "Ideal Customer Segmentation"

    type: number
    sql: ${TABLE}.Months_Billed ;;
  }
  dimension: org_data_maturity {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Org_Data_Maturity ;;
  }
  dimension: project_margin_pct {
    group_label: "Ideal Customer Segmentation"
    hidden: yes
    type: number
    sql: ${TABLE}.Project_Margin__ ;;
  }
  measure: avg_project_margin_pct {
    group_label: "Ideal Customer Segmentation"

    type: average
    value_format_name: percent_0
    sql: ${project_margin_pct} ;;
  }
  dimension: rank {
    group_label: "Ideal Customer Segmentation"

    type: number
    sql: ${TABLE}.Rank ;;
  }
  dimension: service {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Service ;;
  }
  dimension: size {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Size ;;
  }
  dimension: testimonial_url {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Testimonial_URL ;;
  }
  dimension: client_contribution_gbp {
    group_label: "Ideal Customer Segmentation"
    hidden: yes
    type: string
    sql: safe_cast(replace(replace(${TABLE}.Total_Client_Contribution_GBP,'£',''),',','') as float64) ;;
  }
  measure: total_client_contribution_gbp {
    group_label: "Ideal Customer Segmentation"

    type: sum
    value_format_name: gbp_0
    sql: ${client_contribution_gbp} ;;
  }
  measure: avg_client_contribution_gbp {
    group_label: "Ideal Customer Segmentation"

    type: average
    value_format_name: gbp_0
    sql: ${client_contribution_gbp} ;;
  }
  dimension: total_engagements {
    group_label: "Ideal Customer Segmentation"

    type: number
    sql: ${TABLE}.Total_Engagements ;;
  }
  dimension: total_invoiced_revenue_gbp {
    group_label: "Ideal Customer Segmentation"
    hidden: yes
    type: number
    sql: safe_cast(replace(replace(${TABLE}.Total_Invoiced_Revenue_GBP,'£',''),',','') as float64) ;;
  }
  measure: total_revenue_gbp {
    group_label: "Ideal Customer Segmentation"

    type: sum
    value_format_name: gbp_0
    sql: ${total_invoiced_revenue_gbp} ;;
  }
  measure: avg_revenue_gbp {
    group_label: "Ideal Customer Segmentation"

    type: average
    value_format_name: gbp_0
    sql: ${total_invoiced_revenue_gbp} ;;
  }
  dimension: renewals {
    group_label: "Ideal Customer Segmentation"
    hidden: yes
    type: number
    sql: ${TABLE}.Total_Renewals ;;
  }
  measure: total_renewals {
    group_label: "Ideal Customer Segmentation"
    value_format_name: decimal_1
    type: sum
    sql: ${renewals} ;;
  }
  measure: avg_renewals {
    group_label: "Ideal Customer Segmentation"
    value_format_name: decimal_1

    type: average
    sql: ${renewals} ;;
  }
  dimension: total_score {
    group_label: "Ideal Customer Segmentation"
    hidden: yes

    type: number
    sql: ${TABLE}.Total_Score ;;
  }
  dimension: sprints {
    group_label: "Ideal Customer Segmentation"
    hidden: yes

    type: number
    sql: ${TABLE}.Total_Sprints ;;
  }
  measure: total_sprints {
    group_label: "Ideal Customer Segmentation"

    type: sum
    value_format_name: decimal_1
    sql: ${renewals} ;;
  }
  measure: avg_sprints {
    group_label: "Ideal Customer Segmentation"
    value_format_name: decimal_1

    type: average
    sql: ${renewals} ;;
  }
  dimension: vertical {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Vertical ;;
  }
  measure: count {
    group_label: "Ideal Customer Segmentation"

    type: count
    drill_fields: [company_name]
  }
}
