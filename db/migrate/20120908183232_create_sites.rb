class CreateSites < ActiveRecord::Migration
  def up
    create_table :sites do |t|
      t.string :name
      t.integer :hits
      t.integer :total_duration
      t.string :ownedby
      t.integer :isopen

      t.timestamps
    end
  end
end
