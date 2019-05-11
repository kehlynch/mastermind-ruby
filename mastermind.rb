require './round.rb'
require './feedback.rb'
require './codemaker.rb'
require './codebreaker.rb'
require './display.rb'

COLORS = [:red, :green, :blue, :yellow, :purple, :orange]

class Mastermind
  def initialize(debug)
    @display = Display.new(COLORS, debug)
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

debug = ARGV[0] === 'debug'
ARGV.clear
m = Mastermind.new(debug)
m.play
