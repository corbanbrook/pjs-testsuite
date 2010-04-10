class Release < ActiveRecord::Base
  has_many :configurations
  default_scope :order => 'version DESC'
  
  def self.test_count(release)
    count = 0
    release.configurations.each do |c|
      count += c.tests.count
    end
    return count
  end
end
