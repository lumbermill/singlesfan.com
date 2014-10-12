class CreateMasters < ActiveRecord::Migration
  def change
    create_table :masters do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :active, default: true, null: false
      t.binary :picture
      t.text :desc

      t.timestamps
    end
    add_index :masters, :name, unique: true
    add_index :masters, :email, unique: true
  end
end
