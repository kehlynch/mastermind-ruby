class Codebreaker
  def initialize(display)
    @display = display
  end

  def get_guess(guess_count)
    @display.get_guess(guess_count)
  end
end
