require "minitest/sprint_reporter"

module Minitest
  class RakeReporter < SprintReporter
    attr_accessor :name

    def initialize name = nil
      super()
      self.name    = name
    end

    def print_list
      results.each do |result|
        puts ["  rake", name, "N=#{result.class_name}##{result.name}"].compact.join(" ")
      end
    end
  end
end
