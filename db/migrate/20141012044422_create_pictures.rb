class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.binary :origin, limit:10485760
      t.binary :thumb, limit:10485760
      t.string :desc
      t.boolean :active, default: true, null: false
      t.integer :master_id

      t.timestamps
    end
  end
end
