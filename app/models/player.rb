class Player < ActiveRecord::Base
  belongs_to :team
  has_many :player_rounds

  def current_round()
    player_rounds.last
  end

  def round(decade)
    player_rounds[decade]
  end

  def residual_emission(decade)
    # Return precomputed value if already in database
    if not round(decade).residual_emission.nil?
      return round(decade).residual_emission
    end

    constGlobalCO2GrowthPerYear = 0.5

    players_per_team = team.players.count
    residual_emission = round(decade-1).residual_emission + 10*constGlobalCO2GrowthPerYear/players_per_team - round(decade).mitigation

    # Update the database
    round(decade).update_attribute(:residual_emission => residual_emission)
    return residual_emission
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
    # Return precomputed value if already in database
    if not round(decade).baseline_damage.nil?
        return round(decade).baseline_damage
    end

    constDamagePercentPerDegree = 5.714285714

    damagePercentOfGNI = constDamagePercentPerDegree * team.temperature(decade)
    baseline_damage = max(0, predamageGNI(decade)*damagePercentOfGNI/100);

    # Update the database
    round(decade).update_attribute(:baseline_damage => baseline_damage)
    return baseline_damage
  end

  def residual_damage(decade)
    # Return precomputed value if already in database
    if not round(decade).residual_damage.nil?
        return round(decade).residual_damage
    end

    residual_damage = max(0, baseline_damage(decade) - round(decade).adaptation*efficiencyOfAdaptation(team.temperature(decade)))

    # Update the database
    round(decade).update_attribute(:residual_damage => residual_damage)
    return residual_damage
  end

  def gross_national_income(decade)
    # Return precomputed value if already in database
    if not round(decade).gross_national_income.nil?
      return round(decade).gross_national_income
    end

    gross_national_income = predamageGNI(decade) - residual_damage(decade) - round(decade).adaptation

    # Update the database
    round(decade).update_attribute(:gross_national_income => gross_national_income)
    return gross_national_income
  end

end
