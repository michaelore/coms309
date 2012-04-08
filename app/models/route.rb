class Route < ActiveRecord::Base
	serialize :vertices
	belongs_to :start, :class_name => "Location", :inverse_of => :routes_leaving
	belongs_to :ending, :class_name => "Location", :inverse_of => :routes_entering

	def distance
		lat1 = start.avgLat*Math::PI/180
		lon1 = start.avgLon*Math::PI/180
		lat2 = ending.avgLat*Math::PI/180
		lon2 = ending.avgLon*Math::PI/180
		a = Math.sin((lat2-lat1)/2)**2+Math.cos(lat1)*Math.cos(lat2)*Math.sin((lon2-lon1)/2)**2
		c = 2*Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
		return 6367500*c
	end

	def deep
		start = Location.find(self.start_id)
		ending = Location.find(self.ending_id)
		vertices = self.vertices.map {|id| Coordinate.find(id)}
		return {"start" => start, "ending" => ending, "vertices" => vertices}
	end

	def self.getCompositeRoutes(startID, endingID, depth)
		start = Location.find(startID)
		ending = Location.find(endingID)
		return [[]] unless startID != endingID
		return [] unless depth > 0
		comps = []
		start.routes_leaving.each do |r|
			comps.concat(getCompositeRoutes(r.ending_id, endingID, depth-1).map {|comp| [r].concat(comp)})
		end
		return comps
	end
end
