#!/usr/bin/env ruby

# Tab completion for minitest tests.
#
# INSTALLATION:
#
# 1. Put this file in a directory in your $PATH.  Make sure it's executable
# 2. Run this:
#
#   $ complete -o bashdefault -f -C $(gem which minitest/complete) ruby
#
# Running individual minitest tests will now have tab completion for the
# method names.
#
# USAGE:
#
# When running tests, just hit tab after -n.  For example:
#
#   $ ruby -I lib:test test/test_whatever.rb -n test_<TAB>
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
