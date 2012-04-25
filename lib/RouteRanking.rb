class RouteRanking

	##
	#function initialize

	def initialize
		@routes = []
		@sortedRoutes = []
		@averageRank = []
		@stars = []
	end

	##
	#add route in the routes

	def addRoute(id, likes, dislikes)
		@routes.push({:id => id, :likes => likes, :dislikes => dislikes})
		average = likes * 1.0 / (likes + dislikes)
		@averageRank.push({:id => id, :average => average})
	end

	##
	#sort route by average ranking and return the sourted routes

	def sort

		for j in 1..(@averageRank.count - 1)
			key = @averageRank[j][:average]
			key_id = @averageRank[j][:id]
			i = j - 1
			while i >= 0 && @averageRank[i][:average] < key do
				@averageRank[i+1] = @averageRank[i]
				i = i - 1
			end
			@averageRank[i+1] = {:average => key, :id => key_id}
		end
		
		for i in 0..(@averageRank.count - 1)
			score = @averageRank[i][:average]
			id = @averageRank[i][:id]
			@stars[i] = {:star => score, :id => id}
		end
		
		return @averageRank
	end
	
	##
	#get the stars of route based on the likes and dislikes
	
	def star
		
		for i in 0..(@averageRank.count - 1)
			if @stars[i][:star] >= 0.85
				@stars[i][:star] = 5
			elsif @stars[i][:star] >= 0.65 && @stars[i][:star] < 0.85
				@stars[i][:star] = 4
			elsif @stars[i][:star] >= 0.4 && @stars[i][:star] < 0.65
				@stars[i][:star] = 3
			elsif @stars[i][:star] >= 0.15 && @stars[i][:star] < 0.4
				@stars[i][:star] = 2
			elsif @stars[i][:star] > 0 && @stars[i][:star] <0.15
				@stars[i][:star] = 1
			else
				@stars[i][:star] = 0
			end
		end
		
		return @stars
	end
	
end
