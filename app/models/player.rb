class Player < ActiveRecord::Base
  belongs_to :team
  has_many :player_rounds

  def current_round()
    player_rounds.last
  end

  def round(decade)
    player_rounds[decade]
  end

  def residual_emissions(decade)
    if decade==-1
      return 8.5
    end

    constGlobalCO2GrowthPerYear = 0.5

    players_per_team = team.players.count
    residual_emissions(decade-1) + 10*constGlobalCO2GrowthPerYear/players_per_team - round(decade).mitigation
  end

  def costOfMitigation(mitigation)
    # Primitive implementation that should be changed in future
    mitigation
  end

  def efficiencyOfAdaptation(temperature)
    # Primitive implementation
    if temperature<2.0
      return 2.0
    elsif temperature<4.0
      return 3.0
    else
      return 1.0
    end
  end

  def predamageGNI(decade)
    constAnnualGNIGrowth = 1.033

    gross_national_income(decade-1) * constAnnualGNIGrowth**10 - costOfMitigation(round(decade).mitigation)
  end

  def baseline_damage(decade)
    constDamagePercentPerDegree = 5.714285714

    damagePercentOfGNI = constDamagePercentPerDegree * team.temperature(decade)
    [0, predamageGNI(decade)*damagePercentOfGNI/100].max
  end

  def residual_damage(decade)
    [0, baseline_damage(decade) - round(decade).adaptation*efficiencyOfAdaptation(team.temperature(decade))].max
  end

  def gross_national_income(decade)
    if decade==-1
      return 18.0
    end
    predamageGNI(decade) - residual_damage(decade) - round(decade).adaptation
  end

end
