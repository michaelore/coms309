class Route < ActiveRecord::Base
	serialize :vertices
	belongs_to :start, :class_name => "Location", :inverse_of => :routes_leaving
	belongs_to :end, :class_name => "Location", :inverse_of => :routes_entering
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
