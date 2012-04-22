require 'Agent.rb'
require 'RouteRanking.rb'

module ApplicationHelper
	def isMobile
		return Agent.new(request.env['HTTP_USER_AGENT']).os_s
	end

	def sortRoutes(routes)
		rr = RouteRanking.new
		for r in routes
			rr.addRoute(r.id, r.likes, r.dislikes)
		end
		return rr.sort.map {|d| d[:id]}
	end
end
