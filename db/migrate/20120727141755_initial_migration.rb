class InitialMigration < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.timestamps
    end
  end
end
