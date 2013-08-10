class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.references :question, index: true
      t.references :from_user, index: true
      t.references :to_user, index: true

      t.timestamps
    end
  end
end
