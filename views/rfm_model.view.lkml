view: rfm_model {
    derived_table: {
      explore_source: companies_dim {
        column: total_invoice_count_in_clients_last_12m { field: projects_invoiced.total_invoice_count_in_clients_last_12m }
        column: total_invoice_gbp_amount_in_clients_last_12m { field: projects_invoiced.total_invoice_gbp_amount_in_clients_last_12m }
        column: invoice_months_recency { field: projects_invoiced.invoice_months_recency }
        column: company_pk { field: company_deal_value_attribute.company_pk }
        filters: {
          field: projects_invoiced.invoice_gbp_revenue_amount
          value: ">0"
        }
        filters: {
          field: company_deal_value_attribute.company_pk
          value: "-EMPTY"
        }
        derived_column: rfm_frequency_score {
          sql:  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end;;
        }
        derived_column: order_frequency {
          sql:  case when total_invoice_count_in_clients_last_12m between 0 and 1 then '0-1 orders'
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then '1-2 orders'
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then '2-5 orders'
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then '5-10 orders'
                     when total_invoice_count_in_clients_last_12m > 10 then '10+'
                 end;;
        }
        derived_column: rfm_recency_score {
          sql:  case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end;;
        }
        derived_column: order_recency {
          sql:  case when invoice_months_recency between 0 and 5 then '0-5 months'
                     when invoice_months_recency between 5 and 10 then '5-10 months'
                     when invoice_months_recency between 10 and 15 then '10-15 months'
                     when invoice_months_recency between 15 and 20 then '15-20 months'
                     when invoice_months_recency > 20 then '20+'
                 end;;
        }
        derived_column: rfm_monetary_value_score {
          sql:  case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end;;
        }
        derived_column: monetary_value {
          sql:  case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then '> £5k'
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then '£5k-£10k'
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then '£10k-£25k'
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then '£25k-£50k'
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then '£50k+'
                 end;;
        }
        derived_column: rfm_cell {
          sql: concat(
                  case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end,
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end,
                  case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end)
                  ;;
                  }
        derived_column: rfm_segment {
          sql: case when (
                  case when invoice_months_recency between 0 and 5 then 1
                     when invoice_months_recency between 5 and 10 then 2
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 4
                     when invoice_months_recency > 20 then 5
                 end) = 5
                and (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end) = 5
                and
                 (case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end) = 5 then '01: Best Clients'

               when
                (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) = 5
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end) = 1
                and ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) < 4
                 then '05: New Client'
                when
                (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) = 5
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end) = 1
                and ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) >= 4
                 then '04: New Big-Spending Client'
                when
                 (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) = 1
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end
                 ) >= 4
                 and
                 ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) >= 4
                then '10: Lost Big-Spending Client'
                when
                 (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) = 1
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end
                 ) < 3
                 and
                 ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) < 3
                then '12: Lost Cheap Client'
                when
                 (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) = 1
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end
                 ) = 5
                 and
                 ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) < 2
                then '11: Lost Client'
                when
                 (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) <= 3
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end
                 ) = 5
                 and
                 ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) >= 4
                then '08: Almost-Lost Big-Spending Client'
                when
                 (case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) < 3
                and
                 (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end
                 ) = 5
                 and
                 ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) < 2
                then '09: Almost Lost Client'
                when (
                  case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) > 3
                and (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end) >= 3
                  then '02: Loyal Client'
                when (
                  case when total_invoice_count_in_clients_last_12m between 0 and 1 then 1
                     when total_invoice_count_in_clients_last_12m between 1 and 2 then 2
                     when total_invoice_count_in_clients_last_12m between 2 and 5 then 3
                     when total_invoice_count_in_clients_last_12m between 5 and 10 then 4
                     when total_invoice_count_in_clients_last_12m > 10 then 5
                 end) between 2 and 3
                and (
                  case when invoice_months_recency between 0 and 5 then 5
                     when invoice_months_recency between 5 and 10 then 4
                     when invoice_months_recency between 10 and 15 then 3
                     when invoice_months_recency between 15 and 20 then 2
                     when invoice_months_recency > 20 then 1
                 end) between 2 and 3 then '07: Occasional Client'
                when
                 ( case when total_invoice_gbp_amount_in_clients_last_12m between 0 and 5000 then 1
                     when total_invoice_gbp_amount_in_clients_last_12m between 5000 and 10000 then 2
                     when total_invoice_gbp_amount_in_clients_last_12m between 10000 and 25000 then 3
                     when total_invoice_gbp_amount_in_clients_last_12m between 25000 and 50000 then 4
                     when total_invoice_gbp_amount_in_clients_last_12m > 50000 then 5
                 end ) >= 4 then '03: Big-Spending Client'
                else '06: Client'
                end;;
        }
        }





    }
    dimension: company_pk {
      hidden: yes
      label: "        Companies Company Pk"
    }
    dimension: rfm_frequency_score {
      group_label: "RFM Model"
    }
    dimension: rfm_recency_score {
      group_label: "RFM Model"

    }
    dimension: rfm_monetary_value_score {
      group_label: "RFM Model"

    }
  dimension: order_frequency {
    group_label: "RFM Model"
    order_by_field: rfm_frequency_score
  }
  dimension: order_recency {
    group_label: "RFM Model"
    order_by_field: rfm_recency_score

  }
  dimension: monetary_value {
    group_label: "RFM Model"
    order_by_field: rfm_monetary_value_score

  }
    dimension: rfm_cell {
    group_label: "RFM Model"

  }
  dimension: rfm_segment {
    group_label: "RFM Model"

  }
  }