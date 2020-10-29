module Ecco
  module RubyRows
    ROW = 0

    FIRST_COLUMN  = 0
    SECOND_COLUMN = 1

    KEY   = 0
    VALUE = 1

    def self.convert_to_ruby(java_row)
      if java_row.inspect.include?("LinkedList")
        java_linked_list_to_ruby_array(java_row)
      else
        java_array_list_to_ruby_array(java_row)
      end
    end

    def self.java_linked_list_to_ruby_array(java_row)
      ruby_row = Array.new(1) { Array.new(2) }

      ruby_row[ROW][FIRST_COLUMN] = java_row[ROW][FIRST_COLUMN]
      ruby_row[ROW][SECOND_COLUMN] = java_row[ROW][SECOND_COLUMN]

      ruby_row
    end

    def self.java_array_list_to_ruby_array(java_row)
      key_num = java_row[ROW].get_key[KEY]
      key_val = java_row[ROW].get_key[VALUE]
      val_num = java_row[ROW].get_value[KEY]
      val_val = java_row[ROW].get_value[VALUE]

      ruby_tuple = Tuple.new(key: [key_num, key_val], value: [val_num, val_val])
      ruby_row = Array.new(1) { ruby_tuple }

      ruby_row
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
