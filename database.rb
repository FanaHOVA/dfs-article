require 'sequel'

DB = Sequel.sqlite # Use SQLite as an adapter

module Database
  def self.setup
    unless DB.table_exists?(:players)
      DB.create_table :players do
        primary_key :id
        String :name
        Integer :salary
        String :team
        String :matchup
        String :position
        Float :ppg
      end
    end
  end
end
