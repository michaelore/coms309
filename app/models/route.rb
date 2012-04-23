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

	def likes
		count = 0
		ratings.each {|r| count += (r.like == 1 ? 1 : 0)}
		return count
	end

	def dislikes
		count = 0
		ratings.each {|r| count += (r.like == -1 ? 1 : 0)}
		return count
	end

	def coordinates
		start = Location.find(self.start_id)
		ending = Location.find(self.ending_id)
		vertices = self.vertices.map {|id| Coordinate.find(id)}
		coordinates = [{:latitude => start.avgLat, :longitude => start.avgLon}]
		vertices.each { |vert| coordinates.push({:latitude => vert.latitude, :longitude => vert.longitude}) }
		coordinates.push({:latitude => ending.avgLat, :longitude => ending.avgLon})
		return coordinates
	end

	def info(user_id)
		faved = 0
		rate = Rating.find_by_user_id_and_route_id(user_id ? user_id : 0, id)
		if (rate && rate.favorite == 1)
			faved = 1
		end
		return {"start" => start.name, "ending" => ending.name, "likes" => likes, "dislikes" => dislikes, "favorite" => faved}
	end

	def deep
		start = Location.find(self.start_id)
		ending = Location.find(self.ending_id)
		vertices = self.vertices.map {|id| Coordinate.find(id)}
		likes = 0
		dislikes = 0
		ratings.each do |r|
			if r.like == 1
				likes += 1
			elsif r.like == -1
				dislikes += 1
			end
		end
		return {"start" => start, "ending" => ending, "vertices" => vertices, "likes" => likes, "dislikes" => dislikes}
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
