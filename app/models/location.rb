class Location < ActiveRecord::Base
	has_many :coordinates
	has_many :routes_leaving, :class_name => "Route", :inverse_of => :start
	has_many :routes_entering, :class_name => "Route", :inverse_of => :end
end
