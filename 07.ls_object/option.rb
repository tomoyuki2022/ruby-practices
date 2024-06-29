# frozen_string_literal: true

require 'optparse'

class Option
  def initialize
    @params = parse_option
  end

  def dot_match?
    @params[:a] || false
  end

  def long_format?
    @params[:l] || false
  end

  def reverse?
    @params[:r] || false
  end

  private

  def parse_option
    opt = OptionParser.new
    params = {}
    opt.on('-a') { |v| params[:a] = v }
    opt.on('-l') { |v| params[:l] = v }
    opt.on('-r') { |v| params[:r] = v }
    opt.parse!(ARGV)
    params
  end
end
