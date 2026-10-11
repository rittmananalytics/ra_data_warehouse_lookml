view: bonus_attributed_revenue_fact {
  sql_table_name: `{{ _user_attributes['dataset'] }}.bonus_attributed_revenue_fact` ;;

  dimension: bonus_attributed_revenue_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.bonus_attributed_revenue_pk ;;
  }

  dimension: contact_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_fk ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: project_is_fixed_fee {
    type: yesno
    sql: ${TABLE}.project_is_fixed_fee ;;
  }

  dimension: quarter {
    type: string
    sql: ${TABLE}.quarter ;;
  }

  dimension: fixed_fee_revenue_share {
    description: "Fixed-fee projects: this person's share of all weighted hours on the project up to the quarter end."
    type: number
    value_format_name: percent_1
    sql: ${TABLE}.fixed_fee_revenue_share ;;
  }

  measure: hours_billed_in_quarter {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.hours_billed_in_quarter ;;
  }

  measure: attributed_revenue_gbp {
    type: sum
    value_format_name: gbp_0
    sql: ${TABLE}.attributed_revenue_gbp ;;
  }
}
