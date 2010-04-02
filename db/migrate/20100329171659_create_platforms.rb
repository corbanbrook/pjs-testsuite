class CreatePlatforms < ActiveRecord::Migration
  def self.up
    create_table :platforms do |t|
      t.string :name
      t.string :version
      t.string :regexp
    end

    Platform.create :name => "Mac OS X", :version => "10.5", :regexp => "Mac OS X 10[_.]5"
    Platform.create :name => "Mac OS X", :version => "10.6", :regexp => "MacOS X 10[_.]6"  
    Platform.create :name => "Windows", :version => "XP", :regexp => "Windows NT 5.[12]"
    Platform.create :name => "Windows", :version => "Vista", :regexp => "Windows NT 6.0"
    Platform.create :name => "Windows", :version => "7", :regexp => "Windows NT 6.1"
    Platform.create :name => "Linux", :version => "", :regexp => "Linux"
  end

  def self.down
    drop_table :platforms
  end
end
