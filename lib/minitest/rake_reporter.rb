require "minitest/sprint_reporter"

module Minitest
  ##
  # An extra minitest reporter to output how to rerun failures using
  # rake.

  class RakeReporter < SprintReporter
    ##
    # The name of the rake task to rerun. Defaults to nil.

    attr_accessor :name

    def initialize name = nil # :nodoc:
      super()
      self.name    = name
    end

    def print_list # :nodoc:
      results.each do |result|
        puts ["  rake", name, "N=#{result.class_name}##{result.name}"].compact.join(" ")
      end
    end
  end
end
