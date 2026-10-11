view: bs_consultant_revenue_mtd {
  derived_table: {
    sql: WITH revenue AS (
        SELECT DATE_TRUNC(r.billing_month, MONTH) AS billing_month, c.contact_name,
          COALESCE(SUM(r.consultant_recognized_revenue_gbp), 0) AS total_recognized_revenue_gbp
        FROM `ra-development.analytics.companies_dim` cd
        LEFT JOIN `ra-development.analytics.timesheet_projects_dim` pd ON cd.company_pk = pd.company_fk
        LEFT JOIN `ra-development.analytics.recognized_revenue_fact` r ON pd.timesheet_project_pk = r.timesheet_project_pk
        LEFT JOIN `ra-development.analytics.contacts_dim` c ON r.contact_fk = c.contact_pk
        WHERE r.billing_month >= DATE_TRUNC(CURRENT_DATE(), MONTH) AND r.billing_month < DATE_ADD(DATE_TRUNC(CURRENT_DATE(), MONTH), INTERVAL 1 MONTH)
        GROUP BY 1, 2),
      targets AS (
        SELECT DATE_TRUNC(DATE(PARSE_TIMESTAMP('%d-%m-%Y', t.month)), MONTH) AS period_month,
          t.ae_tgt AS ae_revenue_target, t.sae_tgt AS sae_revenue_target, t.prn_tgt AS prn_revenue_target
        FROM `ra-development.analytics_seed.targets` t
        GROUP BY 1, 2, 3, 4),
      merged AS (
        SELECT rv.billing_month, rv.contact_name, rv.total_recognized_revenue_gbp, tg.period_month, tg.ae_revenue_target, tg.sae_revenue_target, tg.prn_revenue_target,
          CASE rv.contact_name
            WHEN 'Bailey Sharpledger' THEN tg.sae_revenue_target
            WHEN 'Jordan Ilyat' THEN tg.sae_revenue_target
            WHEN 'Lydia Blackley' THEN tg.sae_revenue_target
            WHEN 'Saverro Suseno' THEN tg.ae_revenue_target
            WHEN 'Lewis Baker' THEN tg.prn_revenue_target
            WHEN 'Olivier Dupuis' THEN 12767
            ELSE 0 END AS revenue_target
        FROM revenue rv
        LEFT JOIN targets tg ON tg.period_month = rv.billing_month)
      SELECT *, total_recognized_revenue_gbp - revenue_target AS variance, revenue_target - total_recognized_revenue_gbp AS remaining_target_gbp
      FROM merged ;;
  }
  label: "Business Summary: Consultant revenue MTD (tile 2501)"

  dimension: contact_name {
    sql: ${TABLE}.contact_name ;;
  }

  dimension_group: billing_month {
    type: time
    timeframes: [raw, date, month]
    convert_tz: no
    sql: ${TABLE}.billing_month ;;
  }

  dimension_group: period_month {
    type: time
    timeframes: [raw, date, month]
    convert_tz: no
    sql: ${TABLE}.period_month ;;
  }

  measure: ae_revenue_target {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.ae_revenue_target) = 0 THEN NULL ELSE SUM(${TABLE}.ae_revenue_target) END ;;
  }

  measure: prn_revenue_target {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.prn_revenue_target) = 0 THEN NULL ELSE SUM(${TABLE}.prn_revenue_target) END ;;
  }

  measure: remaining_target_gbp {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.remaining_target_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.remaining_target_gbp) END ;;
  }

  measure: revenue_target {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.revenue_target) = 0 THEN NULL ELSE SUM(${TABLE}.revenue_target) END ;;
  }

  measure: sae_revenue_target {
    type: number
    hidden: yes
    sql: CASE WHEN COUNT(${TABLE}.sae_revenue_target) = 0 THEN NULL ELSE SUM(${TABLE}.sae_revenue_target) END ;;
  }

  measure: total_recognized_revenue_gbp {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.total_recognized_revenue_gbp) = 0 THEN NULL ELSE SUM(${TABLE}.total_recognized_revenue_gbp) END ;;
  }

  measure: variance {
    type: number
    value_format_name: gbp_0
    sql: CASE WHEN COUNT(${TABLE}.variance) = 0 THEN NULL ELSE SUM(${TABLE}.variance) END ;;
  }
}
