require "minitest/autorun"
require "minitest/path_expander"

$LOAD_PATH.unshift "test"
$LOAD_PATH.unshift "lib"

class Minitest::Sprint
  VERSION = "1.3.0"

  def self.run args = ARGV
    Minitest::PathExpander.new(args)
      .process { |f| require "./#{f}" }
  end
end
