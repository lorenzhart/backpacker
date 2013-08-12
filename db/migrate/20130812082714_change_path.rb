class ChangePath < ActiveRecord::Migration
  def change
  	change_column :paths, :from_user_id, :integer, :limit => 8
  	change_column :paths, :to_user_id, :integer, :limit => 8
  end
end
