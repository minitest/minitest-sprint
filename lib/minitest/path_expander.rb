require "path_expander"

module Minitest; end # :nodoc:

##
# Minitest's PathExpander to find and filter tests.

class Minitest::PathExpander < PathExpander
  TEST_GLOB = "**/{test_*,*_test,spec_*,*_spec}.rb" # :nodoc:

  def initialize args = ARGV # :nodoc:
    args << "test" if args.empty?
    super args, TEST_GLOB
  end

  ##
  # Overrides PathExpander#process_flags to filter out ruby flags
  # from minitest flags. Only supports -I<paths>, -d, and -w for
  # ruby.

  def process_flags flags
    flags.reject { |flag| # all hits are truthy, so this works out well
      case flag
      when /^-I(.*)/ then
        $LOAD_PATH.concat $1.split(/:/)
      when /^-d/ then
        $DEBUG = true
      when /^-w/ then
        $VERBOSE = true
      else
        false
      end
    }
  end
end
