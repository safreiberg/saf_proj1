class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :site_id
      t.integer :hits
      t.integer :total_duration
      t.string :name

      t.timestamps
    end
  end
end
