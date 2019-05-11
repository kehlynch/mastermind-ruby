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

  def get_play_again?
    input = get_input("Play again? [yn]")
    ["y", "yes"].include?(input.downcase)
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

  def show_victory(guess_count)
    output "Hooray! You won after #{guess_count} guesses!"
  end

  private

  def get_guess_msg
    if @first_guess
      @first_guess = false
      colour_letters
    else
      ""
    end
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

  def get_input(message)
    output("#{message} > ", :print)
    gets.strip
  end

  def output(message, function = :puts)
    if @colorize
      send(function, message.colorize(:background => :light_black))
    else
      send(function, message)
    end
  end
end
