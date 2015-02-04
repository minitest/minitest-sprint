require "minitest/sprint_reporter"

module Minitest
  class BinstubReporter < SprintReporter
    def print_list
      results.each do |result|
        puts "  minitest #{result.class}##{result.name}"
      end
    end
  end
end
