class Configuration < ActiveRecord::Base
  belongs_to :user
  belongs_to :platform
  belongs_to :release
  belongs_to :browser

  has_many :tests
  has_many :examples, :through => :tests
  
  def percent_complete
    example_count = Example.count.to_f
    example_count > 0 ? (self.tests.completed.count / example_count * 100).floor : 0
  end
  
  
  def self.percent_complete(platform, browser, release)
    configurations = Configuration.find_all_by_platform_id_and_browser_id_and_release_id(platform.id, browser.id, release.id)
    unless configurations.empty?
      configurations.max {|a,b| a.percent_complete <=> b.percent_complete}.percent_complete
    end
  end
end
