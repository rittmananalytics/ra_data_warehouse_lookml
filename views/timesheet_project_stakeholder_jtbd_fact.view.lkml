# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: timesheet_project_stakeholder_jtbd_fact {
  hidden: yes
    join: timesheet_project_stakeholder_jtbd_fact__keywords {
      view_label: "Timesheet Project Stakeholder Jtbd Fact: Keywords"
      sql: LEFT JOIN UNNEST(${timesheet_project_stakeholder_jtbd_fact.keywords}) as timesheet_project_stakeholder_jtbd_fact__keywords ;;
      relationship: one_to_many
    }
    join: timesheet_project_stakeholder_jtbd_fact__identified_jtbds {
      view_label: "Timesheet Project Stakeholder Jtbd Fact: Identified Jtbds"
      sql: LEFT JOIN UNNEST(${timesheet_project_stakeholder_jtbd_fact.identified_jtbds}) as timesheet_project_stakeholder_jtbd_fact__identified_jtbds ;;
      relationship: one_to_many
    }
}
view: timesheet_project_stakeholder_jtbd_fact {
  sql_table_name: `ra-development.analytics.timesheet_project_stakeholder_jtbd_fact` ;;

  dimension: company_fk {
    hidden: yes
    type: string
    sql: ${TABLE}.company_fk ;;
  }
  dimension: contact_fk {
    hidden: yes

    type: string
    sql: ${TABLE}.contact_fk ;;
  }
  dimension: contact_name {
    hidden: yes
    type: string
    sql: ${TABLE}.contact_name ;;
  }
  dimension: identified_jtbds {
    group_label: " Stakeholder Jobs to be Done"
    label: "Job To Be Done"
    hidden: yes
    sql: ${TABLE}.identified_jtbds ;;
  }
  dimension: jtbd_summary {
    group_label: " Stakeholder Jobs to be Done"

    label: "Jobs To Be Done Summary"
    type: string
    sql: ${TABLE}.jtbd_summary ;;
  }
  dimension: keywords {
    hidden: yes
    sql: ${TABLE}.keywords ;;
  }
  measure: count {
    hidden: yes

    type: count
    drill_fields: [contact_name]
  }
}

view: timesheet_project_stakeholder_jtbd_fact__keywords {

  dimension: timesheet_project_stakeholder_jtbd_fact__keywords {
    group_label: "Jobs to be Done Keywords"

    label: "JTBD Keyword"
    type: string
    sql: timesheet_project_stakeholder_jtbd_fact__keywords ;;
  }

  measure: count_used {
    type: sum
    sql: 1 ;;
  }
}

view: timesheet_project_stakeholder_jtbd_fact__identified_jtbds {

  dimension: description {
    group_label: "Jobs to be Done"

    label: "JTBD Description"

    type: string
    sql: description ;;
  }
  dimension: jtbd_id {
    hidden: yes
    type: number
    sql: jtbd_id ;;
  }
  dimension: timesheet_project_stakeholder_jtbd_fact__identified_jtbds {
    label: "Job to be Done"
    type: string
    hidden: yes
    sql: timesheet_project_stakeholder_jtbd_fact__identified_jtbds ;;
  }
}
