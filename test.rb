require 'minitest/autorun'
require './feedback.rb'

# tests for the feedback class
class FeedbackTest < Minitest::Test
  def setup; end

  def test_white_not_awarded_if_too_few
    code = %i[yellow orange purple purple]
    guess = %i[purple purple purple orange]
    expected = %i[white blank black white]
    assert_equal Feedback.new(code, guess).pegs, expected
  end

  def test_no_hits
    code = %i[yellow orange purple purple]
    guess = %i[red red red green]
    expected = %i[blank blank blank blank]
    assert_equal Feedback.new(code, guess).pegs, expected
  end
end
