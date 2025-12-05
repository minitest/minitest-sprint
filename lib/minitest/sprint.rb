$LOAD_PATH.unshift "test", "lib"

require "simplecov" if ENV["MT_COV"] || ARGV.delete("--simplecov")
require "minitest/autorun"
require "minitest/path_expander"

##
# Runs (Get it? It's fast!) your tests and makes it easier to rerun individual
# failures.

class Minitest::Sprint
  VERSION = "1.4.1" # :nodoc:

  ##
  # Process and run minitest cmdline.

  def self.run args = ARGV
    Minitest::PathExpander.new(args).process { |f|
      require "./#{f}" if File.file? f
    }
  end
end
