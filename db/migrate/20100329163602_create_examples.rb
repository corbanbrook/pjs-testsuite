class CreateExamples < ActiveRecord::Migration
  def self.up
    create_table :examples do |t|
      t.string :name
      t.string :description
      t.string :p5_url
      t.string :source
    end
  end

  def self.down
    drop_table :examples
  end
end
