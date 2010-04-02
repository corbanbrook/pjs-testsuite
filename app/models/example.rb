class Example < ActiveRecord::Base
  has_many :tests
  has_many :configurations, :through => :tests
end
