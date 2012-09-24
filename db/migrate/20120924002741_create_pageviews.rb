class CreatePageviews < ActiveRecord::Migration
  def change
    create_table :pageviews do |t|
      t.string :location
      t.integer :hittime
      t.integer :site_id

      t.timestamps
    end
  end
end
