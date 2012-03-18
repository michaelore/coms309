class Route < ActiveRecord::Base
	serialize :vertices
	has_and_belongs_to_many :locations
end
