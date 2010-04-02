class User < ActiveRecord::Base
  acts_as_authentic

  has_many :configurations
  has_many :tests
end
