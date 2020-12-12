connection: "demo_bq"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


explore: order_items {}


view: order_items {
  sql_table_name: looker-private-demo.ecomm.order_items ;;

  measure: count { type: count }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price}  ;;
    drill_fields: [status,count]
    value_format_name: usd_0
    link: {
      label: "Drill to Vis | Break Down by count"
      url: "{% assign vis_config = '{
        \"value_labels\": \"legend\",
        \"label_type\": \"labPer\",
        \"inner_radius\": 50,
        \"type\": \"looker_pie\",
        \"x_axis_gridlines\": false,
        \"y_axis_gridlines\": true,
        \"show_view_names\": false,
        \"show_y_axis_labels\": true,
        \"show_y_axis_ticks\": true,
        \"y_axis_tick_density\": \"default\",
        \"y_axis_tick_density_custom\": 5,
        \"show_x_axis_label\": true,
        \"show_x_axis_ticks\": true,
        \"y_axis_scale_mode\": \"linear\",
        \"x_axis_reversed\": false,
        \"y_axis_reversed\": false,
        \"plot_size_by_field\": false,
        \"limit_displayed_rows\": false,
        \"legend_position\": \"center\",
        \"point_style\": \"none\",
        \"show_value_labels\": false,
        \"label_density\": 25,
        \"x_axis_scale\": \"auto\",
        \"y_axis_combined\": true,
        \"ordering\": \"none\",
        \"show_null_labels\": false,
        \"show_totals_labels\": false,
        \"show_silhouette\": false,
        \"totals_color\": \"#808080\",
        \"defaults_version\": 1,
        \"series_types\": {}
      }' %}{{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  dimension: shipped_at {
    type: date
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: delivered_at {
    type: date
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }


}
