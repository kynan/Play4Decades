class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :state, :default => 'new'
      t.integer :nrounds
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
