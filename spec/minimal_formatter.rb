require 'rspec/core/formatters/base_formatter'

class MinimalFormatter < RSpec::Core::Formatters::BaseFormatter
  RSpec::Core::Formatters.register self,
    :example_group_started,
    :example_passed,
    :example_failed,
    :dump_summary

  GREEN = "\e[32m"
  RED   = "\e[31m"
  RESET = "\e[0m"

  def initialize(output)
    super
    @current_group = nil
    @results = Hash.new { |h, k| h[k] = { passed: [], failed: [] } }
  end

  def example_group_started(notification)
    @current_group = notification.group.description.strip
  end

  def example_passed(notification)
    @results[@current_group][:passed] << notification.example.description.strip
  end

  def example_failed(notification)
    @results[@current_group][:failed] << notification.example.description.strip
  end

  def dump_summary(summary)
    @results.each do |group, outcomes|
      output.puts "\n#{group}"
      unless outcomes[:passed].empty?
        output.puts "#{GREEN}  Passed:#{RESET}"
        outcomes[:passed].each { |desc| output.puts "#{GREEN}    - #{desc}#{RESET}" }
      end
      unless outcomes[:failed].empty?
        output.puts "#{RED}  Failed:#{RESET}"
        outcomes[:failed].each { |desc| output.puts "#{RED}    - #{desc}#{RESET}" }
      end
    end

    total = summary.example_count
    failed = summary.failure_count
    passed = total - failed

    output.puts
    output.puts "#{GREEN}Passed: #{passed}#{RESET}"
    output.puts "#{RED}Failed: #{failed}#{RESET}"
    output.puts "Total:  #{total}"
  end
end
