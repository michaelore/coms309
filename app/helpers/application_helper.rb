require 'Agent.rb'

module ApplicationHelper
	def isMobile
		return Agent.new(request.env['HTTP_USER_AGENT']).os_s
	end
end
