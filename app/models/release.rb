class Release < ActiveRecord::Base
  default_scope :order => 'version DESC'
end
