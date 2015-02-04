require "minitest/sprint_reporter"

module Minitest
  class RakeReporter < SprintReporter
    def print_list
      results.each do |result|
        puts "  rake N=#{result.class}##{result.name}"
      end
    end
  end
end
