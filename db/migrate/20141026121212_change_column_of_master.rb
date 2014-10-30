class ChangeColumnOfMaster < ActiveRecord::Migration
  def change
    change_column :masters, :picture, :binary, limit:10485760
    add_column :masters, :broken_dishes, :integer, default: 0
  end
end
