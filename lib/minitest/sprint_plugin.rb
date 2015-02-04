require "minitest"

module Minitest
  def self.plugin_sprint_options opts, options # :nodoc:
    opts.on "--rake", "Report how to re-run failures with rake." do
      options[:sprint] = :rake
    end

    opts.on "--binstub", "Report how to re-run failures with minitest." do
      options[:sprint] = :binstub
    end
  end

  def self.plugin_sprint_init options
    case options[:sprint]
    when :rake then
      require "minitest/rake_reporter"
      self.reporter << Minitest::RakeReporter.new
    when :binstub then
      require "minitest/binstub_reporter"
      self.reporter << Minitest::BinstubReporter.new
    end
  end
end
