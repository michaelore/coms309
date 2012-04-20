class RouteRanking

	def initialize
		@routes = []
	end

	def addRoute(id, likes, dislikes)
		@routes.push({:id => id, :likes => likes, :dislikes => dislikes})
	end
	
	def sort
		return @routes
	end
	
end