class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :opendate
      t.integer :opentime, default: 1 
      t.integer :picture_id
      t.integer :master_id
      t.string :title
      t.string :short_desc
      t.text :long_desc
      t.string :url
      t.integer :submaster_id

      t.timestamps
    end
  end
end
