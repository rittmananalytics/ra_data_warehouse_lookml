# The name of this view in Looker is "Consulting Companies"
view: consulting_companies {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ra-development.analytics_seed.consulting_companies`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Banner" in Explore.

  dimension: banner {
    type: string
    sql: ${TABLE}.banner ;;
  }

  dimension: company_address {
    type: string
    sql: ${TABLE}.companyAddress ;;
  }

  dimension: company_bio {
    type: string
    sql: ${TABLE}.company_bio ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.companyName ;;
  }

  dimension: company_size {
    type: string
    sql: ${TABLE}.companySize ;;
  }

  dimension: company_url {
    type: string
    sql: ${TABLE}.companyUrl ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: dbt_partner_status {
    type: string
    sql: ${TABLE}.dbt_partner_status ;;
  }

  dimension: domain {
    type: string
    sql: ${TABLE}.domain ;;
  }

  dimension: employees_on_linked_in {
    type: number
    sql: ${TABLE}.employeesOnLinkedIn ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_employees_on_linked_in {
    type: sum
    sql: ${employees_on_linked_in} ;;
  }

  measure: average_employees_on_linked_in {
    type: average
    sql: ${employees_on_linked_in} ;;
  }

  dimension: employees_rank {
    type: number
    sql: ${TABLE}.employees_Rank ;;
  }

  dimension: error {
    type: string
    sql: ${TABLE}.error ;;
  }

  dimension: follower_count {
    type: number
    sql: ${TABLE}.followerCount ;;
  }

  dimension: follower_rank {
    type: number
    sql: ${TABLE}.Follower_Rank ;;
  }

  dimension: founded {
    type: number
    sql: ${TABLE}.founded ;;
  }

  dimension: headquarters {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.headquarters ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: is_admin {
    type: yesno
    sql: ${TABLE}.isAdmin ;;
  }

  dimension: linkedin_id {
    type: number
    sql: ${TABLE}.linkedinID ;;
  }

  dimension: logo {
    type: string
    sql: ${TABLE}.logo ;;
  }

  dimension: main_company_id {
    type: number
    sql: ${TABLE}.mainCompanyID ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension: sales_navigator_link {
    type: string
    sql: ${TABLE}.salesNavigatorLink ;;
  }

  dimension: saved_img {
    type: string
    sql: ${TABLE}.savedImg ;;
  }

  dimension: specialties {
    type: string
    sql: ${TABLE}.specialties ;;
  }

  dimension: tag_line {
    type: string
    sql: ${TABLE}.tagLine ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name, name]
  }
}
