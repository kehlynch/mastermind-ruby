require './feedback.rb'

COLORS = [:red, :green, :blue, :yellow, :purple, :orange]

class Mastermind
  def initialize(debug)
    @display = Display.new(debug)
    @codemaker = Codemaker.new(@display)
    @codebreaker = Codebreaker.new(@display)
  end

  def play
    round = Round.new(@display, @codemaker, @codebreaker)
    round.play
    if @display.get_play_again?
      play
    end
  end
end

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
      @display.show_pegs(guess)
      if guess == code
        code_broken = true
      else
        @guess_count += 1
        feedback_pegs = Feedback.new(code, guess).pegs
        @display.show_pegs(feedback_pegs)
      end
    end
    @display.display_victory(@guess_count)
  end
end

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

class Display

  ICONS = {
    red: "🔴",
    green: "💚",
    blue: "💙",
    yellow: "💛",
    purple: "💜",
    orange: "🍊",
    blank: "❌",
    black: "⚫️",
    white: "⚪️",
    hidden: "❓"
  }


  def initialize(debug)
    @debug = debug
    @first_guess = true
    @colorize = false
    if Gem::Specification::find_all_by_name('colorize').any?
      require 'colorize'
      @colorize = true
      @colors = {
        red: :red,
        green: :green,
        blue: :blue,
        yellow: :yellow,
        purple: :magenta,
        orange: [:red, :yellow],
        black: :black,
        white: :white
      }
    end
  end

  def get_name
    get_input("What is your name?")
  end

  def get_guess
    guess_input = get_input(get_guess_msg)
    letters_lookup = COLORS.map{ |c| [c[0], c] }.to_h
    letters = letters_lookup.keys
    matches = guess_input.scan(/[#{letters.join}]/)
    if matches.length != 4
      output("please enter 4 colours #{colour_letters}")
      get_guess
    else
      matches.map{ |l| letters_lookup[l] }
    end
  end

  def get_guess_msg
    if @first_guess
      @first_guess = false
      colour_letters
    else
      ""
    end
  end

  def get_play_again?
    input = get_input("Play again? [yn]")
    ["y", "yes"].include?(input.downcase)
  end


  def colour_letters
    if @colorize
      COLORS.map do |c|
        if @colors[c].is_a?(Symbol)
          c[0].colorize(color: @colors[c], background: :grey)
        else
          c[0].colorize(color: @colors[c][0], background: @colors[c][1])
        end
      end.join
    else
      COLORS.map { |c| c[0] }.join
    end
  end

  def get_play_again?
    input = get_input("Play again? [yn]")
    ["y", "yes"].include?(input.downcase)
  end

  def get_input(message)
    output("#{message} > ", :print)
    gets.strip
  end

  def show_code(code)
    output("Code has been chosen!")
    show_pegs(code, @debug)
    output("Guess from 6 colours", :print)
    show_pegs(COLORS)
  end

  def show_pegs(pegs, show = true)
    if show
      output pegs.map{ |p| ICONS[p] }.join
    else
      output(4.times.collect{ ICONS[:hidden] }.join)
    end
  end

  def display_victory(guess_count)
    output "Hooray! You won after #{guess_count} guesses!"
  end

  def output(message, function = :puts)
    if @colorize
      send(function, message.colorize(:background => :light_black))
    else
      send(function, message)
    end
  end
end

debug = ARGV[0] === 'debug'
ARGV.clear
m = Mastermind.new(debug)
m.play
