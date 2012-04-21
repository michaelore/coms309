class RouteRanking

	def initialize
		@routes = []
		@sortedRoutes = []
		@averageRank = []
		@count = 0
	end

	def addRoute(id, likes, dislikes)
		@routes.push({:id => id, :likes => likes, :dislikes => dislikes})
		average = likes * 1.0 / (likes + dislikes)
		count++
		@averageRank.push({:id => id, :average => average})
	end
	
	def sort
		
		for j in 1..count
			key = averageRank.i.average
			i = j - 1
			while i > 0 && averageRank.i.average > key do
				averageRank.i+1.average = averageRank.i.average
				i = i - 1
			end
			averageRank.i+1.average = key
		end
		
		
		return @sortRoutes
	end
	
end