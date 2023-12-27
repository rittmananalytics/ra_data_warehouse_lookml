view: website_leads {
  derived_table: {
    sql: select invitee_email, invitee_name, Start_Date___Time, enquiry, category, Sales_Qualified_, Closed_Won_, Canceled, Response_1, Proposal_Sent_, Company_Domain, Company_Name, Vertical, Company_Size
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

  dimension: event_type {
    type: string
    sql: "Meeting Booked" ;;
  }

  dimension_group: booking {
    type: time
    timeframes: [date,month,month_num,quarter,quarter_of_year,week,year,hour,hour3]
    sql: parse_timestamp('%Y-%m-%d',split(${TABLE}.Start_Date___Time,' ')[safe_offset(0)]) ;;
  }

  dimension_group: meeting {
    type: time
    timeframes: [date,month,month_num,quarter,quarter_of_year,week,year]
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

  measure: total_closed_won {
    type: sum
    sql: ${closed_won_} ;;
  }



  dimension: canceled {
    type: yesno
    sql: ${TABLE}.Canceled ;;
  }



  dimension: meeting_purpose {
    type: string
    sql: ${TABLE}.Response_1 ;;
  }

  dimension: Company_Name {
  type: string
  sql: ${TABLE}.Company_Name ;;
  }

  dimension: Vertical {
    type: string
    sql: ${TABLE}.Vertical ;;
  }

  dimension: Company_Size {
    type: string
    sql: ${TABLE}.Company_Size ;;
  }


  dimension: proposal_sent {
    hidden: yes
    type: number
    sql: ${TABLE}.Proposal_Sent_;;
  }

  measure: total_proposals_sent {
    type: sum
    sql: ${proposal_sent} ;;
  }

  set: detail {
    fields: [
      invitee_email,
      invitee_name,
      start_date___time,
      enquiry,
      category,
      closed_won_,
      canceled    ]
  }
}
