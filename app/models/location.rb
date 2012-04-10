class Location < ActiveRecord::Base
	has_many :coordinates
	has_many :routes_leaving, :class_name => "Route", :inverse_of => :start, :foreign_key => :start_id
	has_many :routes_entering, :class_name => "Route", :inverse_of => :ending, :foreign_key => :ending_id
	
	def avgLat
		coords = coordinates
		sum = 0
		coords.each do |c|
			sum += c.latitude
		end
		return sum/coords.length
	end

	def avgLon
		coords = coordinates
		sum = 0
		coords.each do |c|
			sum += c.longitude
		end
		return sum/coords.length
	end
end
