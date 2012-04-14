class User < ActiveRecord::Base
  has_secure_password
  has_many :ratings
  has_many :ratees, :class_name => "Route", :through => :ratings, :source => :route
  has_many :usages
  has_many :affiliatees, :class_name => "Route", :through => :usages, :source => :route
end
