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
	
	
	def inspect
		"#Agent:#{name} version:#{version.inspect} engine:\"#{engine.to_s}:#{engine_version}\"os:#{os.to_s.inspect}>"
	end
	
	def == other
		string == other.string
	end
	
	def self.engine_version_for_agent string
		$1 if string = /#{engine_for_user_agent(string)}[\/ ]([\d\w\.\-]+)/i
	end
	
	def self.version_for_user_agent string
		case name = name_for_user_agent(string)
		when :Chrome ; $1 if string =~ /chrome\/([\d\w\.\-]+)/i
		when :Safari ; $1 if string =~ /version\/([\d\w\.\-]+)/i
		else           $1 if string =~ /#{name}[\/ ]([\d\w\.\-]+)/i
		end
	end
  
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
	
	def self.os_for_user_agent string
		case string
		when /windows nt 6\.0/i		; 'Windows Vista'
		when /windows NT 6\.\d+/i	; 'Windos 7'
		when /android/i				; 'Android'
		when /ipad/i				; 'iPad'
		when /linux/i				; 'Linux'
		when /os x (\d+)[._](\d+)/i	; 'OS X #{$1}.#{$2}'
		when /blackBerry/i			; 'BalckBerry'
		when /iphone/i				; 'iPhone'
		else						; 'Unknown'
		end
	end
	
	@agents = []
	
	def self.map os, options = {}
		@agents << [os, options]
	end
	
	def os_s
		if(os == 'iPad' || os == 'BalckBerry' || os == 'iPhone' || os == 'Android')
			return true
		else
			return false
		end
	end
end
