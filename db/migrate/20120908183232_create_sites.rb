class CreateSites < ActiveRecord::Migration
  def up
    create_table :sites do |t|
      t.string :name
      t.integer :hits
      t.integer :total_duration

      t.timestamps
    end
  end
end
