view: order_items {
  sql_table_name: public.order_items ;;
  drill_fields: [id]
  filter: current_date_range {
    type: date
    view_label: "-- Period over Period"
    label: " FILTER: Date Range"
    description: "Select the date range you are interested in using this filter, can be used by itself. Make sure any filter on Event Date covers this period, or is removed."

    convert_tz: yes
  }



  parameter: compare_to {
    view_label: "-- Period over Period"

    description: "Choose the period you would like to compare to. Must be used with Current Date Range filter"
    label: "PARAM: Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Iso Year"
      value: "IsoYear"
    }
    allowed_value: {
      label: "Previous Calendar Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Calendar Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Calendar Year"
      value: "Year"
    }
    allowed_value: {
      label: "Custom"
      value: "Custom"
    }
    default_value: "Period"
  }

  dimension_group: pop_no_tz {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    convert_tz: no
  }

  filter: compare_to_date_range {
    type: date
    view_label: "-- Period over Period"

    label: "FILTER: Compare to Custom Range"
    description: "Select the date range you are interested in using this filter, can be used by itself. Make sure any filter on Event Date covers this period, or is removed."

    convert_tz: yes
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
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
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
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
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
