require "minitest/autorun"
require "minitest/sprint"

class TestMinitestSprint < Minitest::Test
  def test_pass
    assert true
  end

  def test_skip
    skip "nope"
  end

  if ENV["BAD"] then # allows it to pass my CI but easy to demo
    def test_fail
      flunk "write tests or I will kneecap you"
    end

    def test_error
      raise "nope"
    end
  end
end
