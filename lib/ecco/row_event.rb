module Ecco
  RowEvent = Struct.new(:type, :table_id, :database, :table, :rows)
end
