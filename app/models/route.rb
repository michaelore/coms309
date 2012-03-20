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
end
