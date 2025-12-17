# Grade Dimension
# Grade reference data for all grading scales (A-Level, BTEC)

view: dim_grade {
  sql_table_name: `ra-warehouse-dev.analytics.dim_grade` ;;
  drill_fields: [grade, grading_scale, ucas_points]

  # Primary Key
  dimension: grade_key {
    primary_key: yes
    type: number
    sql: ${TABLE}.grade_key ;;
    hidden: yes
  }

  # Natural Key (composite)
  dimension: grade {
    type: string
    sql: ${TABLE}.grade ;;
    label: "Grade"
    description: "Grade value (e.g., 'A*', 'A', 'D*', 'M')"
    order_by_field: grade_sort_order
  }

  dimension: grading_scale {
    type: string
    sql: ${TABLE}.grading_scale ;;
    label: "Grading Scale"
    description: "Grading scale (A-Level, BTEC)"
  }

  # Point Values
  dimension: ucas_points {
    type: number
    sql: ${TABLE}.ucas_points ;;
    label: "UCAS Points"
    description: "UCAS tariff points for this grade"
  }

  dimension: grade_points {
    type: number
    sql: ${TABLE}.grade_points ;;
    label: "Grade Points"
    description: "Internal grade point value"
  }

  dimension: grade_sort_order {
    type: number
    sql: ${TABLE}.grade_sort_order ;;
    label: "Sort Order"
    description: "Sort order for display (1 = highest grade)"
    hidden: yes
  }

  # Grade Classification Flags
  dimension: is_high_grade {
    type: yesno
    sql: ${TABLE}.is_high_grade ;;
    label: "Is High Grade"
    description: "High grade flag (A*-B for A-Level, D*-M for BTEC)"
  }

  dimension: is_pass_grade {
    type: yesno
    sql: ${TABLE}.is_pass_grade ;;
    label: "Is Pass Grade"
    description: "Pass grade flag (A*-E for A-Level, D*-P for BTEC)"
  }

  dimension: is_grade_a_star_to_a {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_a ;;
    label: "Is A*-A"
    description: "Grade is A* or A"
    group_label: "A-Level Grade Ranges"
  }

  dimension: is_grade_a_star_to_b {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_b ;;
    label: "Is A*-B"
    description: "Grade is A* to B"
    group_label: "A-Level Grade Ranges"
  }

  dimension: is_grade_a_star_to_c {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_c ;;
    label: "Is A*-C"
    description: "Grade is A* to C"
    group_label: "A-Level Grade Ranges"
  }

  dimension: is_grade_a_star_to_e {
    type: yesno
    sql: ${TABLE}.is_grade_a_star_to_e ;;
    label: "Is A*-E (Pass)"
    description: "Grade is A* to E (pass)"
    group_label: "A-Level Grade Ranges"
  }

  # Derived dimension for grade category
  dimension: grade_category {
    type: string
    sql: CASE
      WHEN ${is_high_grade} THEN 'High Grade'
      WHEN ${is_pass_grade} THEN 'Pass'
      ELSE 'Fail/Unclassified'
    END ;;
    label: "Grade Category"
    description: "Grade categorization (High Grade, Pass, Fail)"
  }

  # Metadata
  dimension: record_source {
    type: string
    sql: ${TABLE}.record_source ;;
    hidden: yes
  }

  dimension_group: loaded_at {
    type: time
    timeframes: [raw, time, date]
    sql: ${TABLE}.loaded_at ;;
    hidden: yes
  }

  # Measures
  measure: count {
    type: count
    drill_fields: [grade, grading_scale, ucas_points, grade_points]
  }

  measure: total_ucas_points {
    type: sum
    sql: ${ucas_points} ;;
    label: "Total UCAS Points"
    description: "Sum of UCAS tariff points"
  }

  measure: average_ucas_points {
    type: average
    sql: ${ucas_points} ;;
    label: "Avg UCAS Points"
    description: "Average UCAS tariff points"
    value_format_name: decimal_1
  }

  measure: total_grade_points {
    type: sum
    sql: ${grade_points} ;;
    label: "Total Grade Points"
    description: "Sum of internal grade points"
  }

  measure: average_grade_points {
    type: average
    sql: ${grade_points} ;;
    label: "Avg Grade Points"
    description: "Average internal grade points"
    value_format_name: decimal_2
  }
}
