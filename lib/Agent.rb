class Agent


	##
	# user agent string
	
	attr_reader :string
	
	##
	# initialize with user agent string
	def initialize string
		@string = string.strip
	end
	
	##
	# user agent name
	
	def name
		Agent.name_for_user_agent string
	end
	
	##
	# user agent version
	
	def version
		Agent.version_for_user_agent string
	end
	
	##
	# user agent engine
	
	def engine
		Agent.engine_for_user_agent string
	end
	
	## 
	# user agent engine version
	
	def engine_version
		Agent.engine_version_for_agent string
	end
	
	##
	# user agent os
	def os
		Agent.os_for_user_agent string
	end
	
	##
	# user agent string
	def to_s
		string
	end
	
	##
	#inspect
	
	def inspect
		"#Agent:#{name} version:#{version.inspect} engine:\"#{engine.to_s}:#{engine_version}\"os:#{os.to_s.inspect}>"
	end
	
	##
	#check the agent if the same as other agent
	
	def == other
		string == other.string
	end
	
	
	##
	#return engine version for user agent
	
	def self.engine_version_for_agent string
		$1 if string = /#{engine_for_user_agent(string)}[\/ ]([\d\w\.\-]+)/i
	end
	
	##
	#return version for user agent
	
	def self.version_for_user_agent string
		case name = name_for_user_agent(string)
		when :Chrome ; $1 if string =~ /chrome\/([\d\w\.\-]+)/i
		when :Safari ; $1 if string =~ /version\/([\d\w\.\-]+)/i
		else           $1 if string =~ /#{name}[\/ ]([\d\w\.\-]+)/i
		end
	end
  
	##
	#return engine symble for user agent 
	
	def self.engine_for_user_agent string
		case string
		when /webkit/i		; :webkit
		when /khtml/i		; :khtml
		when /konqueror/i	; :konqueror
		when /chrome/i		; :chrome
		when /presto/i		; :presto
		when /gecko/i		; :gecko
		when /msie/i		; :msie
		else				  :unknow
		end
	end
	
	##
	#return name for user agent
	
	def self.name_for_user_agent string
		case string
		when /konqueror/i            ; :Konqueror
		when /chrome/i               ; :Chrome
		when /safari/i               ; :Safari
		when /msie/i                 ; :IE
		when /opera/i                ; :Opera
		when /firefox/i              ; :Firefox
		else                         ; :Unknown
		end
	end
	
	##
	#return os for user agent
	
	def self.os_for_user_agent string
		case string
		when /windows nt 6\.0/i		; 'Windows Vista'
		when /windows NT 6\.\d+/i	; 'Windos 7'
		when /android/i				; 'Android'
		when /ipad/i				; 'iPad'
		when /linux/i				; 'Linux'
		when /os x (\d+)[._](\d+)/i	; 'OS X #{$1}.#{$2}'
		when /blackBerry/i			; 'BlackBerry'
		when /iphone/i				; 'iPhone'
		else						; 'Unknown'
		end
	end
	
	@agents = []
	
	##
	#map user agent os
	
	def self.map os, options = {}
		@agents << [os, options]
	end
	
	##
	#chech wether the user agent is mobile or not
	
	def os_s
		if(os == 'iPad' || os == 'BlackBerry' || os == 'iPhone' || os == 'Android')
			return true
		else
			return false
		end
	end
end
