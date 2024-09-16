# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: thelook.order_items ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;  }
  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;  }
  measure: count {
    type: count
    html:
    <div style="float: left
    ; width:{{ value | times:100}}%

    ; background-color:
    {% if value > 90 %}
rgba(0,180,0,{{ value | times:100 }})
{% elsif value < 90 %}
rgba(180,0,0,{{ value | times:100 }})
{% else %}
rgba(0,200,0,{{ value | times:100 }})
{% endif %}
    ; text-align:left
    ; color: #FFFFFF
    ; border-radius: 5px"> <p style="margin-bottom: 0; margin-left: 4px;">{{ value | times:100 }}%</p>
    </div>
    <div style="float: left
    ; width:{{ 1| minus:value | times:100}}%

    ; background-color:
    {% if value > 90 %}
rgba(0,180,0,{{ value | times:100 }})
{% elsif value < 90 %}
rgba(180,0,0,{{ value | times:100 }})
{% else %}
rgba(0,200,0,{{ value | times:100 }})
{% endif %}

    ; text-align:right
    ; border-radius: 5px"> <p style="margin-bottom: 0; margin-left: 0px; color:rgba(0,0,0,0.0" )>{{value}}</p>
    </div>
    ;;

    drill_fields: [id, orders.id, inventory_items.id]
  }
}
