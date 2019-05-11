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

  def initialize(code_colors, debug)
    @code_colors = code_colors
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
        orange: :red,
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
    letters_lookup = @code_colors.each_with_index.map do |c, i|
      [[c[0], c], [(i + 1).to_s, c]]
    end.flatten(1).to_h
    letters = letters_lookup.keys
    matches = guess_input.scan(/[#{letters.join}123456]/)
    if matches.length != 4
      output("please enter 4 colours #{color_letters}")
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
      output("Guess from 6 colours ", :print)
      show_pegs(@code_colors)
      @first_guess = false
      "#{color_letters} or #{color_numbers}"
    else
      ""
    end
  end

  def color_letters
    if @colorize
      @code_colors.map do |c|
        c[0].colorize(color: @colors[c])
      end.join
    else
      @code_colors.map { |c| c[0] }.join
    end
  end

  def color_numbers
    if @colorize
      @code_colors.each_with_index.map do |c, i|
        (i + 1).to_s.colorize(color: @colors[c])
      end.join
    else
      @code_colors.enum_with_index.map { |c, i| (i + 1).to_s }.join
    end
  end

  def get_input(message)
    output("#{message} >", :print)
    print(" ")
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
