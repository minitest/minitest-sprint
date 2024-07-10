module Minitest
  class SprintReporter < AbstractReporter
    attr_accessor :results
    attr_accessor :options

    def initialize(options)
      self.options = options
      self.results = []
    end

    def record result
      results << result unless result.passed? or result.skipped?
    end

    def report
      return if results.empty?

      puts
      puts "Happy Happy Sprint List:"
      puts
      print_list
      puts
    end
  end
end
