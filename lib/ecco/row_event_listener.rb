require "ecco/event_listener"
require "ecco/row_event"
require_relative "row_type"

module Ecco
  class RowEventListener < EventListener
    def on_event(event)
      data = event.get_data
      type = event.get_header.get_event_type

      case type
      when Ecco::RowType::TABLE_EVENT
        @table_map_event = event
      when *Ecco::RowType.accepted_events
        row_event          = Ecco::RowEvent.new
        row_event.table_id = data.get_table_id
        row_event.rows     = data.rows
        row_event.type     = Ecco::RowType.fetch_event(type)

        if @table_map_event
          table_event_data = @table_map_event.get_data

          row_event.database = table_event_data.get_database
          row_event.table    = table_event_data.get_table
        end

        @callback.call(row_event)
      end
    end
  end
end
