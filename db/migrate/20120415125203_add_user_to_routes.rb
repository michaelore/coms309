class AddUserToRoutes < ActiveRecord::Migration
  def change
    change_table :routes do |t|
      t.integer :user_id
    end
  end
end
