require "sequel"

class DatabaseHelper
  USER = ENV.fetch("DATABASE_USER")
  PASS = ENV.fetch("DATABASE_PASS")
  DB   = Sequel.connect(ENV.fetch("DATABASE_URL"),
    user:     USER,
    password: PASS,
  )

  def self.create_table(name, columns: 1)
    DB.create_table!(name) do
      primary_key :id

      1.upto(columns) do |i|
        String :"column#{i}"
      end
    end
  end

  def self.drop_table(name)
    DB.drop_table(name)
  end

  def self.insert(table_name, values_hash)
    DB[table_name].insert(values_hash)
  end

  def self.update(table_name, id:, columns:)
    DB[table_name].where(id: id).update(columns)
  end

  def self.delete(table_name, id:)
    DB[table_name].where(id: id).delete
  end
end
