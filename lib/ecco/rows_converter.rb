module Ecco
  module RowsConverter
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

    def self.convert_update_rows(java_rows)
      before_update_row = java_rows.first.get_key.to_a
      after_update_row  = java_rows.first.get_value.to_a

      Array.new(1) do
        Tuple.new(
          key: before_update_row,
          value: after_update_row
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
