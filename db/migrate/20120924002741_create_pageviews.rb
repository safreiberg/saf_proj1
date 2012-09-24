class CreatePageviews < ActiveRecord::Migration
  def change
    create_table :pageviews do |t|
      t.string :location
      t.time :hittime
      t.integer :site_id

      t.timestamps
    end
  end
end
