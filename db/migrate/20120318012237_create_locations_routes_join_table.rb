class CreateLocationsRoutesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :locations_routes, :id => false do |t|
      t.integer :location_id
      t.integer :route_id
    end
  end

  def self.down
    drop_table :locations_routes
  end
end
