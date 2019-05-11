class Codemaker
  def initialize(display)
    @display = display
  end

  def get_code
    @code = 4.times.collect{ COLORS.sample }
  end
end

class Codebreaker
  def initialize(display)
    @display = display
  end

  def get_guess
    @display.get_guess
  end
end
