require "minitest/autorun"
require "minitest/path_expander"

$LOAD_PATH.unshift "test"
$LOAD_PATH.unshift "lib"

class Minitest::Sprint
  VERSION = "1.4.1"

  def self.run args = ARGV
    Minitest::PathExpander.new(args)
      .process { |f| require "./#{f}" if File.file? f }
  end
end
