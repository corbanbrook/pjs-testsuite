class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
      t.belongs_to :configuration
      t.belongs_to :example
      t.belongs_to :user

      t.boolean :pass
      t.boolean :is_complete, :default => false
      t.string :note
      t.string :user_agent

      t.timestamps
    end
  end

  def self.down
    drop_table :tests
  end
end
