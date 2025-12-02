#!/usr/bin/env -S ruby

# see instructions in the readme for use

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
K = Class.new(Ripper) { define_method(:on_def) { |n,_,_| methods << n } } # :nodoc:

begin
  K.parse File.read(file), file, 1
  methods = methods.grep(/^#{options[:method]}/) if options[:method]
  puts methods.join("\n")
rescue # give up on parse errors
end
