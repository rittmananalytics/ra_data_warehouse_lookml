view: fathom_meeting_actions {

    derived_table: {
      sql: SELECT * FROM `ra-secure.meeting_transcripts.meeting_actions`  ;;
    }

    measure: total_action_items {
      type: count_distinct
      sql: ${pk};;
    }

    dimension: recording_url {
      type: string
      sql: ${TABLE}.Recording_Url ;;
    }

    dimension: pk {
      type: string
      sql: concat(${recording_url},${action_item_description}) ;;
      primary_key: yes
      hidden: yes
    }



    dimension: action_item_description {
      type: string
      sql: ${TABLE}.Action_Item_Description ;;
    }

    dimension: is_ai_generated {
      type: yesno
      sql: ${TABLE}.Action_Item_Ai_Generated ;;
    }

    dimension: is_completed {
      type: yesno
      sql: ${TABLE}.Action_Item_Completed ;;
    }



    dimension: action_item_contact_name {
      type: string
      sql: ${TABLE}.Action_Item_Assignee_Name ;;
    }

    dimension: action_item_contact_email {
      type: string
      sql: ${TABLE}.Action_Item_Assignee_Email ;;
    }


  }
