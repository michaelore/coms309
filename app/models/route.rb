class Route < ActiveRecord::Base
	serialize :vertices
	belongs_to :start, :class_name => "Location", :inverse_of => :routes_leaving
	belongs_to :end, :class_name => "Location", :inverse_of => :routes_entering

	def distance
		lat1 = start.latitude*Math.pi/180
		lon1 = start.longitude*Math.pi/180
		lat2 = end.latitude*Math.pi/180
		lon2 = end.longitude*Math.pi/180
		a = Math.sin((lat2-lat1)/2)**2+Math.cos(lat1)*Math.cos(lat2)*sin((lon2-lon1)/2)**2
		c = 2*Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
		return 6367500*c
	end

	def deep
		start = Location.find(self.start_id)
		ending = Location.find(self.end_id)
		vertices = self.vertices.map {|id| Coordinate.find(id)}
		return {"start" => start, "end" => ending, "vertices" => vertices}
	end

	def self.getCompositeRoutes(startID, endID, depth)
		start = Location.find(startID)
		ending = Location.find(endID)
		return [[]] unless startID != endID
		return [] unless depth > 0
		comps = []
		start.routes_leaving.each do |r|
			comps.concat(getCompositeRoutes(r.end_id, endID, depth-1).map {|comp| [r].concat(comp)})
		end
		return comps
	end
end
