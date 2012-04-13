class Usage < ActiveRecord::Base
	belongs_to :user
	belongs_to :route
end
