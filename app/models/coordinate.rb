class Coordinate < ActiveRecord::Base
	belongs_to :location

	def self.distance(lat1, lon1, lat2, lon2) # passed in degrees
		lat1 = lat1*Math::PI/180
		lon1 = lon1*Math::PI/180
		lat2 = lat2*Math::PI/180
		lon2 = lon2*Math::PI/180
		a = Math.sin((lat2-lat1)/2)**2+Math.cos(lat1)*Math.cos(lat2)*Math.sin((lon2-lon1)/2)**2
		c = 2*Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
		return 6367500*c
	end
end
