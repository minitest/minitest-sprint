module Minitest
  class SprintReporter < AbstractReporter
    attr_accessor :style
    attr_accessor :results

    def initialize style = :regexp
      self.results = []
      self.style = style
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

    def print_list
      case style
      when :regexp
        results.each do |result|
          puts "  minitest -n #{result.class_name}##{result.name}"
        end
      when :lines
        files = Hash.new { |h,k| h[k] = [] }
        results.each do |result|
          path, line = result.source_location
          path = path.delete_prefix "#{Dir.pwd}/"
          files[path] << line
        end

        files.sort.each do |path, lines|
          puts "  minitest %s:%s" % [path, lines.sort.join(",")]
        end
      else
        raise "unsupported style: %p" % [style]
      end
    end
  end
end
