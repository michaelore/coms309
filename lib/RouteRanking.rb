class RouteRanking

	##
	#function initialize

	def initialize
		#contains id, likes and dislikes of each route
		@routes = []
		
		#sorted array that contains id and average ranking of each route
		@averageRank = []
		
		#contains id and stars rank of each route
		@stars = []
	end

	##
	#add route in the routes
	#push route information including id, likes, and dislike into routes 
	#find the average ranking by likes divided by the total rates
	#push the average ranking and id into averageRank

	def addRoute(id, likes, dislikes)
		
		@routes.push({:id => id, :likes => likes, :dislikes => dislikes})
		average = likes * 1.0 / (likes + dislikes)
		@averageRank.push({:id => id, :average => average})
		
	end

	##
	#sort route by average ranking and return the sourted routes
	#use insertion sort algorithm for sorting the average ranking
	#prepare for the stars

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
		
		#add sorted route into stars to find the 
		for i in 0..(@averageRank.count - 1)
			score = @averageRank[i][:average]
			id = @averageRank[i][:id]
			@stars[i] = {:star => score, :id => id}
		end
		
		return @averageRank
	end
	
	##
	#return the routes including id, likes, and dislikes without sorting
	
	def getRoute
		return @routes
	end
	
	##
	#get the stars of route based on the likes and dislikes
	#rank star by average ranking
	#average ranking is between 0.85 to 1.00, 5 stars
	#average ranking is between 0.65 to 0.85, 4 stars
	#average ranking is between 0.40 to 0.65, 3 stars
	#average ranking is between 0.15 to 0.40, 2 stars
	#average ranking is between 0.00 to 0.15, 1 star
	#average ranking is 0, no star
	
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
			elsif @stars[i][:star] > 0 && @stars[i][:star] < 0.15
				@stars[i][:star] = 1
			else
				@stars[i][:star] = 0
			end
		end
		
		return @stars
	end
	
end
