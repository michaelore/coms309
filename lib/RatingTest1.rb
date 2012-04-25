require 'RouteRanking.rb'

##
#test class for RouteRanking.rb

class RatingTest1
	
	a = RouteRanking.new()

	for i in 0..100
		likes = rand(1000)
		dislikes = rand(1000)
		a.addRoute(i, likes, dislikes)
	end
	
	puts a.sort
	puts 
	puts a.star
	puts
	puts a.getRoute
end