class CreateSites < ActiveRecord::Migration
  def up
    create_table :sites do |t|
      t.string :name
      t.integer :hits

      t.timestamps
    end
  end
end
