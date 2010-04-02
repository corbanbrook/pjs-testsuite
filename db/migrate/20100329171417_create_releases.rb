class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :version
    end

    Release.create :version => "0.4.0"
    Release.create :version => "0.5.0"
    Release.create :version => "0.6.0"
    Release.create :version => "0.7.0"
    Release.create :version => "0.7.1"
  end

  def self.down
    drop_table :releases
  end
end
