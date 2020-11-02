module Ecco
  module RowsConverter
    COLUMN_ID_BEFORE    = 0
    COLUMN_VALUE_BEFORE = 1
    COLUMN_ID_AFTER     = 0
    COLUMN_VALUE_AFTER  = 1

    def self.convert(java_rows, type)
      if type == "UPDATE_ROWS"
        convert_update_rows(java_rows)
      else
        convert_write_or_delete_rows(java_rows)
      end
    end

    def self.convert_write_or_delete_rows(java_rows)
      java_rows.to_a
    end

    def self.java_array_list_to_ruby_array(java_rows)
      before_update_key   = java_rows.first.get_key[COLUMN_ID_BEFORE]
      before_update_value = java_rows.first.get_key[COLUMN_VALUE_BEFORE]
      after_update_key    = java_rows.first.get_value[COLUMN_ID_AFTER]
      after_update_value  = java_rows.first.get_value[COLUMN_VALUE_AFTER]

      Array.new(1) do
        Tuple.new(
          key: [before_update_key, before_update_value],
          value: [after_update_key, after_update_value]
        )
      end
    end
  end

  class Tuple
    KEY   = 0
    VALUE = 1

    attr_reader :tuple

    def initialize(key:, value:)
      @tuple = [key, value]
    end

    def key
      @tuple[KEY]
    end

    def value
      @tuple[VALUE]
    end

    def inspect
      @tuple.to_s
    end
  end
end
