class CreateBrowsers < ActiveRecord::Migration
  def self.up
    create_table :browsers do |t|
      t.string :name
    end

    Browser.create :name => "Firefox"
    Browser.create :name => "Minefield"
    Browser.create :name => "Chrome"
    Browser.create :name => "Safari"
    Browser.create :name => "Opera"
  end

  def self.down
    drop_table :browsers
  end
end
