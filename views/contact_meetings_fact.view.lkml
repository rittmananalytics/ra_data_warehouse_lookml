# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view


# The name of this view in Looker is "Contact Meetings Fact"
view: contact_meetings_fact {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics.contact_sales_meetings_fact`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: all_attendee_person_pk {
    hidden: yes
    sql: ${TABLE}.all_attendee_person_fk ;;
  }

 dimension: company_fk {
  hidden: yes

  sql: (SELECT max(company_fk)  FROM UNNEST(all_company_fk) as company_fk WHERE company_fk != 'f0d582da39b8661f0a9e8d6ebe1ea224' ) ;;
}




  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "All Company Pk" in Explore.

  dimension: all_company_pk {
    hidden: yes
    sql: ${TABLE}.all_company_fk ;;
  }

  dimension: meeting_pk {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.meeting_pk ;;
  }

  dimension: engagement_id {
    hidden:yes
    primary_key: no
    sql: ${TABLE}.engagement_id ;;
  }

  dimension: deal_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.deal_fk ;;
  }

  dimension: is_meeting_active {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_meeting_active ;;
  }

  dimension: meeting_host_person_pk {
    hidden: yes

    type: string
    sql: ${TABLE}.meeting_host_person_fk ;;
  }

  dimension: meeting_owner_id {
    hidden: yes

    type: number
    sql: ${TABLE}.meeting_owner_id ;;
  }

  dimension: meeting_title {
    group_label: "Deal Meetings"
    type: string
    sql: ${TABLE}.meeting_title ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: meeting_ts {
    group_label: "Deal Meetings"
    label: "Meeting"
    type: time
    timeframes: [
      date

    ]
    sql: ${TABLE}.meeting_ts ;;
  }

  dimension: meeting_type {
    group_label: "Deal Meetings"

    type: string
    sql: ${TABLE}.meeting_type ;;
  }

  measure: total_meetings {
    hidden: no
    label: "Total Deal Meetings"
    type: count_distinct
    sql: ${meeting_pk} ;;
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
    sql: contact_meetings_fact__all_company_fk ;;
  }
}

# The name of this view in Looker is "Contact Meetings Fact All Attendee Person Pk"
view: contact_meetings_fact__all_attendee_person_pk {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Contact Meetings Fact All Attendee Person Pk" in Explore.

  dimension: contact_meetings_fact__all_attendee_person_pk {
    hidden: yes
    type: string
    sql: contact_meetings_fact__all_attendee_person_pk ;;
  }
}
