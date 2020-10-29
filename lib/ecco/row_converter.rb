module Ecco
  module RubyConverter
    FIRST_COLUMN = 0
    SECOND_COLUMN = 1
    KEY = 0
    VALUE = 1
    ROW = 0

    def self.to_ruby(java_rows, type)
      if type == "UPDATE_ROWS"
        java_array_list_to_ruby_array(java_rows)
      else
        java_linked_list_to_ruby_array(java_rows)
      end
    end

    def self.java_linked_list_to_ruby_array(java_rows)
      Array.new(1) do
        [java_rows[ROW][FIRST_COLUMN],
         java_rows[ROW][SECOND_COLUMN]]
      end
    end

    def self.java_array_list_to_ruby_array(java_rows)
      before_update_key   = java_rows[ROW].get_key[KEY]
      before_update_value = java_rows[ROW].get_key[VALUE]
      after_update_key    = java_rows[ROW].get_value[KEY]
      after_update_value  = java_rows[ROW].get_value[VALUE]

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
