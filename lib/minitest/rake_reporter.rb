require "minitest/sprint_reporter"

module Minitest
  class RakeReporter < SprintReporter
    def print_list
      results.each do |result|
        puts ["  rake", options[:rake_task], "N=#{result.class_name}##{result.name}"].compact.join(" ")
      end
    end
  end
end
