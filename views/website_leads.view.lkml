view: website_leads {
  derived_table: {
    sql: select invitee_email, invitee_name, Start_Date___Time, enquiry, category, Sales_Qualified_, Closed_Won_, Canceled, Event_Type_Name, Response_1
      from analytics_seed.website_leads
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: pk {
    sql: concat(${invitee_email},${start_date___time}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: invitee_email {
    type: string
    sql: ${TABLE}.invitee_email ;;
  }

  dimension: invitee_name {
    type: string
    sql: ${TABLE}.invitee_name ;;
  }

  dimension: start_date___time {
    type: string
    hidden: yes
    sql: ${TABLE}.Start_Date___Time ;;
  }

  dimension_group: meeting {
    type: time
    timeframes: [date,month,month_num,quarter,quarter_of_year,year]
    sql: parse_timestamp('%Y-%m-%d',split(${TABLE}.Start_Date___Time,' ')[safe_offset(0)]) ;;
  }

  dimension: enquiry {
    type: number
    hidden: yes
    sql: ${TABLE}.enquiry ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }



  dimension: sales_qualified {
    hidden: yes

    type: number
    sql: ${TABLE}.Sales_Qualified_ ;;
  }

  dimension: closed_won_ {
    hidden: yes

    type: number
    sql: ${TABLE}.Closed_Won_ ;;
  }

  measure: total_sqls {
    type: sum
    sql: ${sales_qualified} ;;
  }

  measure: total_mqls {
    type: sum
    sql: ${enquiry} ;;
  }



  dimension: canceled {
    type: yesno
    sql: ${TABLE}.Canceled ;;
  }

  dimension: event_type_name {
    type: string
    sql: ${TABLE}.Event_Type_Name ;;
  }

  dimension: meeting_purpose {
    type: string
    sql: ${TABLE}.Response_1 ;;
  }

  set: detail {
    fields: [
      invitee_email,
      invitee_name,
      start_date___time,
      enquiry,
      category,
      closed_won_,
      canceled,
      event_type_name,
    ]
  }
}
