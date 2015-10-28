require "ecco/event_listener"

module Ecco
  class RowEventListener < EventListener
    RowEvent = Struct.new(:type, :table_id, :database, :table, :rows)

    ROW_EVENTS = [
      EventType::WRITE_ROWS,
      EventType::UPDATE_ROWS,
      EventType::DELETE_ROWS,
    ]

    def on_event(event)
      super(event)

      case @type
      when EventType::TABLE_MAP
        @table_map_event = event
      when *ROW_EVENTS
        row_event          = RowEvent.new
        row_event.type     = @type.to_s
        row_event.table_id = @data.get_table_id
        row_event.rows     = @data.rows

        if @table_map_event
          event_data = @table_map_event.get_data

          row_event.database = event_data.get_database
          row_event.table    = event_data.get_table
        end

        @client.on_row_event_callback.call(row_event)
      end
    end
  end
end
