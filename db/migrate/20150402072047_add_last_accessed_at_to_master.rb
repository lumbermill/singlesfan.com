class AddLastAccessedAtToMaster < ActiveRecord::Migration
  def change
    add_column :masters, :last_accessed_at, :datetime
  end
end
