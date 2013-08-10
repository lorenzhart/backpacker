class AddFacebookFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :uid, :integer, :limit => 8
    add_column :users, :provider, :string
  end
end
