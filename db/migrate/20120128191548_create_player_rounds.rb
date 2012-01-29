class CreatePlayerRounds < ActiveRecord::Migration
  def self.up
    create_table :player_rounds do |t|
      t.integer :player_id
      t.integer :decade
      t.integer :mitigation, :default => 0
      t.integer :adaptation, :default => 0
      t.float :gross_national_income, :default => 17.5
      t.float :residual_emissions, :default => 8.0
      t.float :baseline_damage
      t.float :residual_damage
      t.timestamps
    end
  end

  def self.down
    drop_table :player_rounds
  end
end
