view: ideal_customers {
  sql_table_name: `ra-development.analytics_seed.ideal_customers` ;;

  dimension: appeal_of_ra_to_buyer {
    group_label: "Ideal Customer Segmentation"
    type: string
    sql: ${TABLE}.Appeal_of_RA_to_Buyer ;;
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
    sql: ${TABLE}.`Buyer Role` ;;
  }
  dimension: company_name {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.`Company Name` ;;
  }
  dimension: department {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Department ;;
  }
  dimension: segment {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.`Grouping` ;;
  }
  dimension: is_digital_native {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.is_digital_native ;;
  }
  dimension: is_icp {
    group_label: "Ideal Customer Segmentation"

    type: yesno
    sql: ${TABLE}.is_icp = "Y" ;;
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
  dimension: org_data_maturity {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Org_Data_Maturity ;;
  }
  dimension: rank {
    group_label: "Ideal Customer Segmentation"

    type: number
    sql: ${TABLE}.Rank ;;
  }
  dimension: size {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Size ;;
  }
  dimension: vertical {
    group_label: "Ideal Customer Segmentation"

    type: string
    sql: ${TABLE}.Vertical ;;
  }

}