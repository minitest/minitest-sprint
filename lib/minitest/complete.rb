#!/usr/bin/env -S ruby

# see instructions in the readme for use

require 'optparse'
require 'shellwords'

argv = Shellwords.split(ENV['COMP_LINE'] || "")
argv = ARGV if argv.empty?
argv.drop 1

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

# TODO: account for running as bin/minitest being a file
file = argv.find { |f| File.file?(f) && !File.directory?(f) }

exit unless options.key?(:method) && file

require 'prism'

class MethodFinder < Prism::Visitor
  attr_accessor :methods

  def initialize methods
    self.methods = methods
  end

  def visit_def_node node
    super
    methods << node.name
  end
end

begin
  methods = []
  Prism.parse_file(file).value.accept MethodFinder.new methods
  methods = methods.grep(/#{options[:method]}/)
  puts methods.join "\n"
end
