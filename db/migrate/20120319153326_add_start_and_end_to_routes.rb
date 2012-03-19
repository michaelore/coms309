class AddStartAndEndToRoutes < ActiveRecord::Migration
  def self.up
    change_table :routes do |t|
      t.integer :start_id
      t.integer :end_id
    end
  end

  def self.down
      remove_column :routes, :start_id
      remove_column :routes, :end_id
  end
end
