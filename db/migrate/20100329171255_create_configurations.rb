class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.belongs_to :user
      t.belongs_to :platform
      t.belongs_to :release
      t.belongs_to :browser
      t.string     :additional_info
      t.integer    :current_example_id
      t.boolean    :is_complete, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
