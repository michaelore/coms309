class Location < ActiveRecord::Base
	has_many :coordinates
	has_and_belongs_to_many :routes
end
