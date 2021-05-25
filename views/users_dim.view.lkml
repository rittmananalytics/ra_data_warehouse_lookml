view: users_dim {
  sql_table_name: `{{ _user_attributes['dbt_dataset'] }}.users_dim`
    ;;

  dimension: all_user_emails {
    hidden: yes
    type: string
    sql: ${TABLE}.all_user_emails ;;
  }

  dimension: all_user_ids {
    hidden: yes
    type: string
    sql: ${TABLE}.all_user_ids ;;
  }

  dimension: user_cost_rate {
    group_label: "Consultant Details"

    type: number
    sql: case when ${TABLE}.user_cost_rate = 100 then 32 else ${TABLE}.user_cost_rate end ;;
  }

  dimension_group: user_created_ts {
    group_label: "Consultant Details"

    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.user_created_ts ;;
  }

  dimension: user_default_hourly_rate {
    group_label: "Consultant Details"

    type: number
    sql: ${TABLE}.user_default_hourly_rate ;;
  }

  dimension: user_is_active {
    group_label: "Consultant Details"

    type: yesno
    sql: ${TABLE}.user_is_active ;;
  }

  dimension: user_is_contractor {
    group_label: "Consultant Details"

    type: yesno
    sql: ${TABLE}.user_is_contractor ;;
  }

  dimension: user_is_staff {
    group_label: "Consultant Details"

    type: yesno
    sql: ${TABLE}.user_is_staff ;;
  }

  dimension_group: user_last_modified_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.user_last_modified_ts ;;
  }

  dimension: user_name {
    group_label: "Consultant Details"

    type: string
    sql: ${TABLE}.user_name ;;
  }

  dimension: user_phone {
    group_label: "Consultant Details"

    type: string
    sql: ${TABLE}.user_phone ;;
  }

  dimension: user_pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.user_pk ;;
  }

  dimension: user_weekly_capacity {
    group_label: "Consultant Details"

    type: number
    sql: ${TABLE}.user_weekly_capacity ;;
  }


}