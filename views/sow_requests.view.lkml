view: sow_requests {
      derived_table: {
      sql: select d.deal_pk,s.* from `ra-development.analytics_seed.sow_requests` s
              left join `ra-development.analytics.deals_fact` d
              on s.statement_of_work_number = d.deal_id
              where d.deal_pk is not null;;
    }



    dimension: deal_pk {
      hidden: yes
      type: string
      primary_key: yes
      sql: ${TABLE}.deal_pk ;;
    }

    dimension_group: timestamp {
      hidden: yes

      type: time
      sql: ${TABLE}.Timestamp ;;
    }

    dimension: email_address {
      hidden: yes

      type: string
      sql: ${TABLE}.Email_Address ;;
    }

    dimension: client_name {
      hidden: yes

      type: string
      sql: ${TABLE}.Client_Name ;;
    }

    dimension: project_name {
      hidden: yes

      type: string
      sql: ${TABLE}.Project_Name ;;
    }

    dimension: sow_background{
      type: string
      sql: ${TABLE}.Background_to_project ;;
    }

    dimension: sow_services_schedule {
      type: string
      sql: ${TABLE}.Services_to_be_Delivered ;;
    }

    dimension: sow_fee_schedule {
      type: string
      sql: ${TABLE}.Fee_Schedule ;;
    }

    dimension: sow_total_contract_value {
      type: string
      sql: ${TABLE}.Total_Contract_Value ;;
    }

    dimension: sow_invoicing_schedule {
      type: string
      sql: ${TABLE}.Invoicing_Schedule ;;
    }

    dimension: sow_cancellation_policy {
      type: string
      sql: ${TABLE}.Cancellation_Policy ;;
    }

    dimension: sow_nature_of_data_processing {
      type: string
      sql: ${TABLE}.Nature_of_Data_Processing ;;
    }

    dimension: sow_purpose_of_data_processing {
      type: string
      sql: ${TABLE}.Purpose_of_Data_Processing ;;
    }

    dimension: sow_types_of_personal_data {
      type: string
      sql: ${TABLE}.Types_of_Personal_Data ;;
    }

    dimension: sow_contact_name {
      type: string
      sql: ${TABLE}.Contact_Name ;;
    }

    dimension: sow_contact_title {
      type: string
      sql: ${TABLE}.Contact_Title ;;
    }

    dimension: contact_email {
      hidden: yes
      type: string
      sql: ${TABLE}.Contact_Email ;;
    }

    dimension: contact_phone {
      hidden: yes
      type: string
      sql: ${TABLE}.Contact_Phone ;;
    }

    dimension: client_address {
      type: string
      hidden: yes

      sql: ${TABLE}.Client_Address ;;
    }

    dimension: client_state_country {
      type: string
      hidden: yes

      sql: ${TABLE}.Client_State_Country ;;
    }

    dimension: sow_categories_of_data_subject {
      type: string
      sql: ${TABLE}.Categories_of_Data_Subject ;;
    }

    dimension: statement_of_work_number {
      hidden: yes
      type: number
      sql: ${TABLE}.Statement_of_Work_Number ;;
    }


  }
