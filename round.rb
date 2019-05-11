class Round
  def initialize(display, codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @display = display
    @guess_count = 0
  end

  def play
    code_broken = false
    code = @codemaker.get_code
    @display.show_code(code)
    until code_broken
      guess = @codebreaker.get_guess
      @guess_count += 1
      @display.show_pegs(guess)
      if guess == code
        code_broken = true
      else
        feedback_pegs = Feedback.new(code, guess).pegs
        @display.show_pegs(feedback_pegs)
      end
    end
    @display.show_victory(@guess_count)
  end
end
