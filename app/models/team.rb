class Team < ActiveRecord::Base
  belongs_to :game
  has_many :players
  has_many :team_rounds

  def round(decade)
    team_rounds[decade]
  end

  def gwi(round)
    70 * (1.033 ** (round*10))
  end

  def global_emissions(decade) 
    emissions = 0
    players.each do |player|
     emissions += player.residual_emissions(decade)
    end
    return emissions
  end

  def cumulativeGlobalCO2(decade)
    if decade == -1
      return 0.0
    end

    cumulativeGlobalCO2 = cumulativeGlobalCO2(decade-1)
    (1..10).each do |year|
      globalEmissions = 0.0
      players.each do |player|
        alpha = year.to_f/10
        cumulativeGlobalCO2 += alpha*player.residual_emissions(decade) + (1-alpha)*player.residual_emissions(decade)
      end
    end
    return cumulativeGlobalCO2
  end

  def temperature(decade)
    if decade == -1
      return 0.0
    end

    constTempIncreasePerCO2 = 0.004;
    self.cumulativeGlobalCO2(decade) * constTempIncreasePerCO2
  end

end
