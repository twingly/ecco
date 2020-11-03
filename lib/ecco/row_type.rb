module Ecco
  class RowType
    java_import com.github.shyiko.mysql.binlog.event.EventType

    # MySQL v1 and v2 row events
    EVENTS = {
      EventType::WRITE_ROWS      => "WRITE_ROWS",
      EventType::EXT_WRITE_ROWS  => "WRITE_ROWS",
      EventType::UPDATE_ROWS     => "UPDATE_ROWS",
      EventType::EXT_UPDATE_ROWS => "UPDATE_ROWS",
      EventType::DELETE_ROWS     => "DELETE_ROWS",
      EventType::EXT_DELETE_ROWS => "DELETE_ROWS"
    }

    TABLE_EVENT = EventType::TABLE_MAP

    def self.accepted_events
      self::EVENTS.keys
    end

    def self.fetch_event(type)
      self::EVENTS.fetch(type)
    end
  end

  class RowTypeSave < RowType
    EVENTS = {
      EventType::QUERY  => "QUERY",
      EventType::ROTATE => "ROTATE"
    }.merge(EVENTS)
  end
end
