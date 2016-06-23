class RussianRoulette
  attr_reader :chamber_position, :loaded_chamber

  def initialize
    load_bullet
    spin_chamber
  end

  def load_bullet
    @loaded_chamber = random_chamber
  end

  def spin_chamber
    @chamber_position = random_chamber
  end

  def pull_trigger!
    if chamber_position == loaded_chamber
      :dead
    else
      :alive
    end
  end

  private def random_chamber
    1.upto(6).to_a.sample
  end
end

