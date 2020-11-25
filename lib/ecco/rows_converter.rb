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
      java_rows.map do |java_row|
        before_update_row = java_row.get_key.to_a
        after_update_row  = java_row.get_value.to_a

        UpdateRowsEventUpdatedRow.new(
          before: before_update_row,
          after:  after_update_row
        )
      end
    end
  end

  class UpdateRowsEventUpdatedRow
    attr_reader :before
    attr_reader :after

    def initialize(before:, after:)
      @before = before
      @after  = after
    end

    # Make sure we don't break existing code
    alias_method :key, :before
    alias_method :value, :after
  end
end
