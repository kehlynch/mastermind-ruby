require 'minitest/autorun'
require './feedback.rb'

class FeedbackTest < Minitest::Test
  def setup
  end

  def test_white_not_awarded_if_too_few
    code = [:yellow, :orange, :purple, :purple]
    guess = [:purple, :purple, :purple, :orange]
    expected = [:white, :blank, :black, :white]
    assert_equal Feedback.new(code, guess).pegs, expected
  end

  def test_no_hits
    code = [:yellow, :orange, :purple, :purple]
    guess = [:red, :red, :red, :green]
    expected = [:blank, :blank, :blank, :blank]
    assert_equal Feedback.new(code, guess).pegs, expected
  end
end
