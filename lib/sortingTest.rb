require 'RouteRanking.rb'
a = RouteRanking.new
a.addRoute(1, 2, 3)
a.addRoute(2, 2, 4)
a.addRoute(3, 2, 3)
a.addRoute(4, 4, 5)
a.addRoute(5, 7, 8)
a.addRoute(6, 10, 1)
a.addRoute(7, 100, 1)
a.addRoute(8, 0, 100)
a.sort
puts a.star
