require "ecco/event_listener"
require "ecco/row_event"

module Ecco
  class RowEventListener < EventListener
    # MySQL v1 and v2 row events
    WRITE_EVENTS  = [EventType::WRITE_ROWS,  EventType::EXT_WRITE_ROWS]
    UPDATE_EVENTS = [EventType::UPDATE_ROWS, EventType::EXT_UPDATE_ROWS]
    DELETE_EVENTS = [EventType::DELETE_ROWS, EventType::EXT_DELETE_ROWS]

    ROW_EVENTS  = WRITE_EVENTS + UPDATE_EVENTS + DELETE_EVENTS

    def table_event
      EventType::TABLE_MAP
    end

    def accepted_events
      ROW_EVENTS
    end

    def on_event(event)
      data = event.get_data
      type = event.get_header.get_event_type

      case type
      when table_event
        @table_map_event = event
      when *accepted_events
        row_event          = Ecco::RowEvent.new
        row_event.table_id = data.get_table_id
        row_event.rows     = data.rows
        row_event.type     = row_type_to_string(type)

        if @table_map_event
          table_event_data = @table_map_event.get_data

          row_event.database = table_event_data.get_database
          row_event.table    = table_event_data.get_table
        end

        @callback.call(row_event)
      end
    end

    private

    def row_type_to_string(type)
      if WRITE_EVENTS.include?(type)
        "WRITE_ROWS"
      elsif UPDATE_EVENTS.include?(type)
        "UPDATE_ROWS"
      elsif DELETE_EVENTS.include?(type)
        "DELETE_ROWS"
      end
    end
  end
end
