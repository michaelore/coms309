class RouteRanking

	##
	#function initialize
	
	def initialize
		@routes = []
		@sortedRoutes = []
		@averageRank = []
	end

	##
	#add route in the routes
	
	def addRoute(id, likes, dislikes)
		@routes.push({:id => id, :likes => likes, :dislikes => dislikes})
		average = likes * 1.0 / (likes + dislikes + 1)
		@averageRank.push({:id => id, :average => average})
	end
	
	##
	#sort route by average ranking and return the sourted routes
	
	def sort
		
		for j in 1..(@averageRank.count-1)
			key = @averageRank[j][:average]
			i = j - 1
			while i >= 0 && @averageRank[i][:average] < key do
				@averageRank[i+1][:average] = @averageRank[i][:average]
				i = i - 1
			end
			@averageRank[i+1][:average] = key
		end
		
		return @averageRank
	end
	
end