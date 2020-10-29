module Ecco
  class RowEvent
    attr_accessor :type, :table_id, :database, :table, :rows

    def initialize
      @table_id = nil
      @database = nil
      @table = nil
      @rows = nil
      @type = nil
    end
  end

  class RowEventWrite < RowEvent
    def initialize
      super
      @type = "WRITE_ROWS"
    end
  end

  class RowEventDelete < RowEvent
    def initialize
      super
      @type = "DELETE_ROWS"
    end
  end

  class RowEventUpdate < RowEvent
    def initialize
      super
      @type = "UPDATE_ROWS"
    end
  end
end
