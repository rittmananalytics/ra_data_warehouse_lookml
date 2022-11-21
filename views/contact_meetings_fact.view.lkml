# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: contact_meetings_fact {
  hidden: yes

  join: contact_meetings_fact__all_company_pk {
    view_label: "Contact Meetings Fact: All Company Pk"
    sql: LEFT JOIN UNNEST(${contact_meetings_fact.all_company_pk}) as contact_meetings_fact__all_company_pk ;;
    relationship: one_to_many
  }

  join: contact_meetings_fact__all_attendee_contact_pk {
    view_label: "Contact Meetings Fact: All Attendee Contact Pk"
    sql: LEFT JOIN UNNEST(${contact_meetings_fact.all_attendee_contact_pk}) as contact_meetings_fact__all_attendee_contact_pk ;;
    relationship: one_to_many
  }
}

# The name of this view in Looker is "Contact Meetings Fact"
view: contact_meetings_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.contact_meetings_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: all_attendee_contact_pk {
    hidden: yes
    sql: ${TABLE}.all_attendee_contact_pk ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "All Company Pk" in Explore.

  dimension: all_company_pk {
    hidden: yes
    sql: ${TABLE}.all_company_pk ;;
  }

  dimension: meeting_pk {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.meeting_pk ;;
  }

  dimension: engagement_id {
    hidden: no
    primary_key: no
    sql: ${TABLE}.engagement_id ;;
  }

  dimension: deal_pk {
    type: string
    sql: ${TABLE}.deal_pk ;;
  }

  dimension: is_meeting_active {
    type: yesno
    sql: ${TABLE}.is_meeting_active ;;
  }

  dimension: meeting_host_contact_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.meeting_host_contact_pk ;;
  }

  dimension: meeting_owner_id {
    hidden: yes

    type: number
    sql: ${TABLE}.meeting_owner_id ;;
  }

  dimension: meeting_title {
    type: string
    sql: ${TABLE}.meeting_title ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: meeting_ts {
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
    sql: ${TABLE}.meeting_ts ;;
  }

  dimension: meeting_type {
    type: string
    sql: ${TABLE}.meeting_type ;;
  }

  measure: total_meetings {
    hidden: no
    type: count_distinct
    sql: ${engagement_id} ;;
    drill_fields: []
  }
}

# The name of this view in Looker is "Contact Meetings Fact All Company Pk"
view: contact_meetings_fact__all_company_pk {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Contact Meetings Fact All Company Pk" in Explore.

  dimension: contact_meetings_fact__all_company_pk {
    type: string
    sql: contact_meetings_fact__all_company_pk ;;
  }
}

# The name of this view in Looker is "Contact Meetings Fact All Attendee Contact Pk"
view: contact_meetings_fact__all_attendee_contact_pk {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Contact Meetings Fact All Attendee Contact Pk" in Explore.

  dimension: contact_meetings_fact__all_attendee_contact_pk {
    hidden: yes
    type: string
    sql: contact_meetings_fact__all_attendee_contact_pk ;;
  }
}
