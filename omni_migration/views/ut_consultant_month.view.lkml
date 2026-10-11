view: ut_consultant_month {
  derived_table: {
    sql: WITH rev AS (
        SELECT c.contact_name, FORMAT_DATE('%Y-%m', r.billing_month) AS month_key,
               COALESCE(SUM(r.consultant_recognized_attributed_revenue_gbp), 0) AS attributed_revenue_gbp  -- Looker shows 0 for a month whose fact rows carry no value
        FROM `ra-development.analytics.companies_dim` cd
        JOIN `ra-development.analytics.timesheet_projects_dim` pd ON cd.company_pk = pd.company_fk
        JOIN `ra-development.analytics.recognized_revenue_fact` r ON pd.timesheet_project_pk = r.timesheet_project_pk
        LEFT JOIN `ra-development.analytics.contacts_dim` c ON r.contact_fk = c.contact_pk
        GROUP BY 1, 2
      ),
      tgt AS (
        SELECT contact_name, FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP(PARSE_DATE('%d-%m-%Y', month))) AS month_key,
               SUM(revenue_target) AS revenue_target, AVG(utilisation_target) AS utilisation_target
        FROM `ra-development.analytics_seed.consultant_targets_grades`
        GROUP BY 1, 2
      ),
      hrs AS (
        SELECT u.contact_name, FORMAT_TIMESTAMP('%Y-%m', t.timesheet_billing_date) AS month_key,
               SUM(COALESCE(t.timesheet_hours_billed, 0)) AS total_hours,
               SUM(CASE WHEN t.timesheet_is_billable THEN COALESCE(t.timesheet_hours_billed, 0) ELSE 0 END) AS billable_hours,
               SUM(CASE WHEN k.task_name NOT IN ('Sickness', 'Annual Leave') OR k.task_name IS NULL THEN COALESCE(t.timesheet_hours_billed, 0) ELSE 0 END) AS available_hours,
               SUM(CASE WHEN k.task_name = 'Sickness' THEN COALESCE(t.timesheet_hours_billed, 0) ELSE 0 END) AS sickness_hours
        FROM `ra-development.analytics.companies_dim` cd
        JOIN `ra-development.analytics.timesheet_projects_dim` pd ON cd.company_pk = pd.company_fk
        JOIN `ra-development.analytics.timesheets_fact` t ON pd.timesheet_project_pk = t.timesheet_project_fk
        LEFT JOIN `ra-development.analytics.contacts_dim` u ON t.contact_fk = u.contact_pk
        LEFT JOIN `ra-development.analytics.timesheet_tasks_dim` k ON t.timesheet_task_fk = k.timesheet_task_pk
        GROUP BY 1, 2
      )
      -- Revenue and hours side by side per consultant and month. has_revenue marks the rows Looker's merge keeps at month grain
      -- (the revenue query is primary); quarter and year tiles keep every month's hours and drop consultant-periods with no revenue.
      -- target_contact_name is the consultant as the targets table knows it: Looker's Contact Name control filters through that table.
      SELECT CONCAT(COALESCE(rev.contact_name, hrs.contact_name, ''), '|', COALESCE(rev.month_key, hrs.month_key)) AS pk,
             COALESCE(rev.contact_name, hrs.contact_name) AS contact_name, COALESCE(rev.month_key, hrs.month_key) AS month_key,
             TIMESTAMP(PARSE_DATE('%Y-%m', COALESCE(rev.month_key, hrs.month_key))) AS billing_month,
             rev.month_key IS NOT NULL AS has_revenue,
             -- targets join the revenue side in Looker: a revenue row without a target has no target name and drops under the control; an hours-only row keeps its own name
             CASE WHEN rev.month_key IS NOT NULL THEN tgt.contact_name ELSE hrs.contact_name END AS target_contact_name,
             rev.month_key IS NOT NULL AND tgt.revenue_target IS NOT NULL AS has_target,
             rev.attributed_revenue_gbp,
             CASE WHEN rev.month_key IS NOT NULL THEN tgt.revenue_target END AS revenue_target_amount,
             CASE WHEN rev.month_key IS NOT NULL THEN tgt.utilisation_target END AS utilisation_target_value,
             hrs.total_hours, hrs.billable_hours, hrs.available_hours, hrs.sickness_hours
      FROM rev
      FULL OUTER JOIN hrs ON hrs.contact_name = rev.contact_name AND hrs.month_key = rev.month_key
      LEFT JOIN tgt ON tgt.contact_name = COALESCE(rev.contact_name, hrs.contact_name) AND tgt.month_key = COALESCE(rev.month_key, hrs.month_key) ;;
  }
  label: "Utilisation & Attributed Revenue"

  dimension: attributed_revenue_gbp {
    hidden: yes
    sql: ${TABLE}.attributed_revenue_gbp ;;
  }

  dimension: available_hours {
    hidden: yes
    sql: ${TABLE}.available_hours ;;
  }

  dimension: billable_hours {
    hidden: yes
    sql: ${TABLE}.billable_hours ;;
  }

  dimension: contact_name {
    label: "Contact Name"
    sql: ${TABLE}.contact_name ;;
  }

  dimension: has_revenue {
    type: yesno
    label: "Has Attributed Revenue"
    description: "The consultant has attributed revenue in the month (the rows Looker's merge keeps at month grain)"
    sql: ${TABLE}.has_revenue ;;
  }

  dimension: has_target {
    type: yesno
    label: "Has Revenue Target"
    description: "A revenue target row exists for the consultant and month"
    sql: ${TABLE}.has_target ;;
  }

  dimension: month_key {
    hidden: yes
    sql: ${TABLE}.month_key ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.pk ;;
  }

  dimension: revenue_target_amount {
    hidden: yes
    sql: ${TABLE}.revenue_target_amount ;;
  }

  dimension: sickness_hours {
    hidden: yes
    sql: ${TABLE}.sickness_hours ;;
  }

  dimension: target_contact_name {
    label: "Contact Name (targets)"
    description: "For a month with revenue, the consultant's name on the targets table (null when no target exists, as Looker's Contact Name control filters revenue rows through that table); for an hours-only month, the consultant's own name"
    sql: ${TABLE}.target_contact_name ;;
  }

  dimension: total_hours {
    hidden: yes
    sql: ${TABLE}.total_hours ;;
  }

  dimension: utilisation_target_value {
    hidden: yes
    sql: ${TABLE}.utilisation_target_value ;;
  }

  dimension_group: billing_month {
    type: time
    timeframes: [raw, date, month, quarter, year]
    label: "Billing Month"
    sql: ${TABLE}.billing_month ;;
  }

  measure: bonus_gbp {
    type: number
    label: "Bonus"
    description: "3% of attributed revenue when it beats the target (Looker calculation bonus on 3659 and 3660)"
    value_format_name: gbp_0
    sql: CASE WHEN ${total_recognized_revenue_attributed_gbp} > ${revenue_target} THEN ${total_recognized_revenue_attributed_gbp} * 0.03 ELSE 0 END ;;
  }

  measure: revenue_target {
    type: number
    label: "Revenue Target"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.revenue_target_amount) = 0 THEN NULL ELSE SUM(${TABLE}.revenue_target_amount) END ;;
  }

  measure: revenue_variance_gbp {
    type: number
    label: "Target Revenue Variance"
    description: "Attributed revenue minus revenue target (Looker dashboard 389 tile 3694 calculation)"
    value_format_name: gbp_0
    sql: ${total_recognized_revenue_attributed_gbp} - ${revenue_target} ;;
  }

  measure: revenue_vs_target_pct {
    type: number
    label: "Revenue vs. Target %"
    value_format_name: percent_0
    sql: safe_divide(${total_recognized_revenue_attributed_gbp}, ${revenue_target}) ;;
  }

  measure: sickness_pct {
    type: number
    label: "Sickness %"
    description: "Sickness hours over available hours (merge calculations sickness on 3702, avg_sickness on 3704)"
    value_format_name: percent_1
    sql: safe_divide(${total_sickness_hours}, ${total_available_hours}) ;;
  }

  measure: total_available_hours {
    type: number
    label: "Total Available Hours"
    description: "Hours on tasks other than Sickness and Annual Leave (Looker custom measure total_available_hours)"
    value_format_name: decimal_0
    sql: CASE WHEN COUNT(${TABLE}.available_hours) = 0 THEN NULL ELSE SUM(${TABLE}.available_hours) END ;;
  }

  measure: total_recognized_revenue_attributed_gbp {
    type: number
    label: "Total Recognized Revenue Attributed GBP"
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.attributed_revenue_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.attributed_revenue_gbp) END ;;
  }

  measure: total_sickness_hours {
    type: number
    label: "Total Sickness Hours"
    value_format_name: decimal_0
    sql: CASE WHEN COUNT(${TABLE}.sickness_hours) = 0 THEN NULL ELSE SUM(${TABLE}.sickness_hours) END ;;
  }

  measure: total_timesheet_billable_hours_billed {
    type: number
    label: "Total Billable Hours"
    value_format_name: decimal_0
    sql: CASE WHEN COUNT(${TABLE}.billable_hours) = 0 THEN NULL ELSE SUM(${TABLE}.billable_hours) END ;;
  }

  measure: total_timesheet_hours_billed {
    type: number
    label: "Total Hours"
    value_format_name: decimal_0
    sql: CASE WHEN COUNT(${TABLE}.total_hours) = 0 THEN NULL ELSE SUM(${TABLE}.total_hours) END ;;
  }

  measure: utilisation_available_pct {
    type: number
    label: "Utilisation (of available hours)"
    description: "Billable hours over available hours (merge calculation utilisation on 3658, 3690, 3699 avg, 3704)"
    value_format_name: percent_0
    sql: safe_divide(${total_timesheet_billable_hours_billed}, ${total_available_hours}) ;;
  }

  measure: utilisation_pct {
    type: number
    label: "Utilisation"
    description: "Billable hours over total hours (merge calculation utilisation on 3659, 3660, 3689, 3691, 3692, 3697 to 3700)"
    value_format_name: percent_0
    sql: safe_divide(${total_timesheet_billable_hours_billed}, ${total_timesheet_hours_billed}) ;;
  }

  measure: utilisation_target {
    type: number
    label: "Utilisation Target"
    value_format_name: percent_0
    sql: AVG(${TABLE}.utilisation_target_value) ;;
  }
}
