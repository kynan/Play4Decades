class CreateTeamRounds < ActiveRecord::Migration
  def self.up
    create_table :team_rounds do |t|
      t.integer :team_id
      t.integer :decade
      t.float :temperature, :default => 0.0
      t.float :cumulative_global_co2, :default => 0.0
      t.timestamps
    end
  end

  def self.down
    drop_table :team_rounds
  end
end
