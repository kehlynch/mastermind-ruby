require './round.rb'
require './feedback.rb'
require './codemaker.rb'
require './codebreaker.rb'
require './display.rb'

CODE_COLORS = %i[red green blue yellow purple orange].freeze

# control the game, continuous rounds of code setting and guessing
class Mastermind
  def initialize(debug)
    @display = Display.new(CODE_COLORS, debug)
    @codemaker = Codemaker.new(@display, CODE_COLORS)
    @codebreaker = Codebreaker.new(@display)
  end

  def play
    round = Round.new(@display, @codemaker, @codebreaker)
    round.play
    play if @display.get_play_again?
  end
end

debug = ARGV[0] == 'debug'
ARGV.clear
m = Mastermind.new(debug)
m.play
