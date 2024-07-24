# The name of this view in Looker is "Xss"
view: xss {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: thelook.xss ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Attack Strings" in Explore.

  dimension: attack_strings {
    type: string
    sql: ${TABLE}.attack_strings ;;
  }
  measure: count {
    type: count
  }
}
