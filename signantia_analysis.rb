#!/usr/bin/env ruby

require 'optparse'

require_relative 'lib/signantia_analysis'

puts "\n***signantia_analysis***\n\n"

# read options                                                                 #

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: signantia_analysis.rb [options]"
  
  opts.on(
    '-d',
    "--database DATABASE",
    "The database URI",
    "  e.g. sqlite:db/example.sqlite3"
    ) do |database|
    options[:database] = database
  end
  
  opts.on(
    '-c',
    "--corpus CORPUS",
    "The corpus path",
    "  e.g. spec/corpus/"
    ) do |corpus|
    options[:corpus] = corpus
  end
  
  opts.on(
    '-r',
    "--regex REGEX",
    "The regex to match",
    "  e.g. /[\\S+]/"
    ) do |regex|
    options[:regex] = regex
  end
end.parse!

# options are available in options, remaining arguments in ARGV

puts "options:"
puts "  database: #{options[:database]}"
puts "  corpus:   #{options[:corpus]}"
puts "  regex:    #{options[:regex]}"
puts ""

# set up database                                                              #

puts "* set up database"
start = Time.now

#DataMapper::Logger.new(
#  STDOUT,
#  :debug
#  )

DataMapper.setup(
  :default,
  options[:database] || 'sqlite:db/development.sqlite3'
  )

DataMapper.finalize

DataMapper.auto_upgrade!

puts "  time: #{Time.now - start}"
puts ""

# do analysis                                                                  #

puts "* doing analysis"
start = Time.now

@corpus = SignantiaAnalysis::Corpus.first_or_create(:path => options[:corpus])

@corpus.analyse(options[:regex])

puts "  time:      #{Time.now - start}"
puts "  files:     #{@corpus.analyses(:regex => options[:regex]).count}"
puts "  words:     #{@corpus.analyses(:regex => options[:regex]).fragments.aggregate(:text, :frequency.sum).count}"
puts "  total:     #{@corpus.analyses(:regex => options[:regex]).fragments.sum(:frequency)}"
puts ""

#                                                                              #


