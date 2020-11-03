require "ecco/event_listener"
require "ecco/row_event"
require "ecco/rows_converter"

module Ecco
  class RowEventListener < EventListener
    def initialize(client)
      super(client, events_of_interest)
    end

    def on_event(event)
      data = event.get_data
      type = event.get_header.get_event_type

      case type
      when TABLE_EVENT
        @table_map_event = event
      when *accepted_events
        row_event          = Ecco::RowEvent.new
        row_event.table_id = data.get_table_id
        row_event.type     = event_type_to_string(type)
        row_event.rows     = Ecco::RowsConverter.convert(data.rows, row_event.type)

        if @table_map_event
          table_event_data = @table_map_event.get_data

          row_event.database = table_event_data.get_database
          row_event.table    = table_event_data.get_table
        end

        @callback.call(row_event)
      end
    end

    private

    def events_of_interest
      [WRITE_EVENTS, UPDATE_EVENTS, DELETE_EVENTS]
    end
  end
end
