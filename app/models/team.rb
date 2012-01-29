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
    emission = 0
    players.each do |player|
     emission += player.residual_emission(decade)
    end
    return emission
  end

  def cumulativeGlobalCO2(decade)
    # Return precomputed value if already in database 
    if not round(decade).cumulativeGlobalCO2.nil?
      return round(decade).cumulativeGlobalCO2
    end

    cumulativeGlobalCO2 = cumulativeGlobalCO2(decade-1)
    (1..10).each do |year|
      globalEmissions = 0.0
      players.each do |player|
        alpha = year.to_f/10
        cumulativeGlobalCO2 += alpha*player.residual_emissions(decade) + (1-alpha)*player.residual_emissions(decade)
      end
    end

    # Update the database 
    round(decade).update_attribute(:cumulativeGlobalCO2 => cumulativeGlobalCO2)
    return cumulativeGlobalCO2
  end

  def temperature(decade)
    # Return precomputed value if already in database 
    if not round(decade).temperature.nil?
      return round(decade).temperature
    end

    constTempIncreasePerCO2 = 0.004;
    temperature = cumulativeGlobalCO2(decade) * constTempIncreasePerCO2

    # Update the database 
    round(decade).update_attribute(:temperature => temperature)
    return temperature
  end

end
