class AddJobUrlFacebookMixiTwitterToMaster < ActiveRecord::Migration
  def change
    add_column :masters, :job, :string
    add_column :masters, :url, :string
    add_column :masters, :id_facebook, :string
    add_column :masters, :id_mixi, :string
    add_column :masters, :id_twitter, :string
  end
end
