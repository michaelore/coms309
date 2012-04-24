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
		averageRanking = likes * 1.0 / (likes + dislikes)
		totalRanking = 0
		
		for i in 0..(@averageRank.count)
			totalRanking = totalRanking + averageRanking
		end
		
		average = (totalRanking + averageRanking) / totalRanking
		
		@averageRank.push({:id => id, :average => average})
	end
	
	##
	#sort route by average ranking and return the sourted routes
	
	def sort
		
		for j in 1..(@averageRank.count-1)
			key = @averageRank[j][:average]
			key_id = @averageRank[j][:id]
			i = j - 1
			while i >= 0 && @averageRank[i][:average] < key do
				@averageRank[i+1] = @averageRank[i]
				i = i - 1
			end
			@averageRank[i+1] = {:average => key, :id => key_id}
		end
		
		return @averageRank
	end
	
end