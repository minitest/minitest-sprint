#!/usr/bin/env ruby

# Tab completion for minitest tests.
#
# Add this to your .bashrc (or .zshrc?--someone please confirm with a PR):
#
#   $ complete -o bashdefault -f -C 'ruby --disable-gems $(gem which minitest/complete)' ruby minitest
#
# Running individual minitest tests will now have tab completion for the
# method names.
#
# USAGE:
#
# When running tests, just hit tab after -n.  For example:
#
#   $ minitest test/test_whatever.rb -n test_thingy<TAB><TAB>
#   test_thingy_error
#   test_thingy_error_teardown
#   test_thingy_failing
#   test_thingy_failing_filtered
#   ... etc ...
#

require 'optparse'
require 'shellwords'

argv = Shellwords.split(ENV['COMP_LINE']).drop 1
options = {}

begin
  OptionParser.new do |opts|
    opts.on("-n", "--name [METHOD]", "Test method") do |m|
      options[:method] = m
    end
  end.parse!(argv)
rescue
  retry # ignore options passed to Ruby
end

file = argv.find { |f| File.file?(f) && !File.directory?(f) }

exit unless options.key?(:method) && file

require 'ripper'

methods = []
K = Class.new(Ripper) { define_method(:on_def) { |n,_,_| methods << n } }

begin
  K.parse File.read(file), file, 1
  methods = methods.grep(/^#{options[:method]}/) if options[:method]
  puts methods.join("\n")
rescue # give up on parse errors
end
