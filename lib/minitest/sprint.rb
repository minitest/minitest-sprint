require "minitest/autorun"
require "minitest/path_expander"

$LOAD_PATH.unshift "test"
$LOAD_PATH.unshift "lib"

class Minitest::Sprint
  VERSION = "1.2.2"

  def self.run args = ARGV
    Minitest::PathExpander.new(args).process.each do |f|
      require "./#{f}"
    end
  end
end
