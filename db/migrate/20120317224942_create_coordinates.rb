class CreateCoordinates < ActiveRecord::Migration
  def self.up
    create_table :coordinates do |t|
      t.float :latitude
      t.float :longitude
      t.float :accuracy
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :coordinates
  end
end
