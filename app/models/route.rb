class Route < ActiveRecord::Base
	serialize :vertices
	belongs_to :start, :class_name => "Location", :inverse_of => :routes_leaving
	belongs_to :ending, :class_name => "Location", :inverse_of => :routes_entering
	has_many :ratings
	has_many :raters, :class_name => "User", :through => :ratings, :source => :user
	has_many :usages
	has_many :affiliaters, :class_name => "User", :through => :usages, :source => :user

	def distance
		coordinates = vertices.map {|v| Coordinate.find(v)}
		if coordinates.length == 0
			return Coordinate.distance(start.avgLat, start.avgLon, ending.avgLat, ending.avgLon)
		end
		sum = 0
		sum += Coordinate.distance(start.avgLat, start.avgLon, coordinates[0].latitude, coordinates[0].longitude)
		sum += Coordinate.distance(ending.avgLat, ending.avgLon, coordinates[-1].latitude, coordinates[-1].longitude)
		(0..(coordinates.length-2)).each do |i|
			sum += Coordinate.distance(coordinates[i].latitude, coordinates[i].longitude, coordinates[i+1].latitude, coordinates[i+1].longitude)
		end
		return sum
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
	
	def self.getMinimalCompositeBy(method, startID, endingID, depth)
		bestComp = nil
		getCompositeRoutes(startID, endingID, depth).each do |comp|
			if bestComp == nil || bestComp.inject(0) {|sum, r| sum+r.send(method)} > comp.inject(0) {|sum, r| sum+r.send(method)}
				bestComp = comp
			end
		end
		return bestComp
	end
end
