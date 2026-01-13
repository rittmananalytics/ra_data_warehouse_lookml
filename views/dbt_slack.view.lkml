# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: dbt_slack {
  hidden: yes

  join: dbt_slack__slack_channels {
    view_label: "Dbt Slack: Slack Channels"
    sql: LEFT JOIN UNNEST(${dbt_slack.slack_channels}) as dbt_slack__slack_channels ;;
    relationship: one_to_many
  }
}

# The name of this view in Looker is "Dbt Slack"
view: dbt_slack {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.dbt_slack`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Display Name" in Explore.

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: job_title {
    type: string
    sql: ${TABLE}.job_title ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: last_updated_ts {
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
    sql: ${TABLE}.last_updated_ts ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: skype {
    type: string
    sql: ${TABLE}.skype ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: slack_channels {
    hidden: yes
    sql: ${TABLE}.slack_channels ;;
  }

  measure: count {
    type: count
    drill_fields: [last_name, display_name, first_name]
  }
}

# The name of this view in Looker is "Dbt Slack Slack Channels"
view: dbt_slack__slack_channels {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Dbt Slack Slack Channels" in Explore.

  dimension: dbt_slack__slack_channels {
    type: string
    sql: dbt_slack__slack_channels ;;
  }
}
