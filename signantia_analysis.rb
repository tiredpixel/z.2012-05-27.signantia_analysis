#!/usr/bin/env ruby

require 'optparse'

require_relative 'lib/signantia_analysis'

puts "signantia_analysis"

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

# set up database                                                              #

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

# do analysis                                                                  #

@corpus = SignantiaAnalysis::Corpus.first_or_create(:path => options[:corpus])

@corpus.analyse(options[:regex])

#                                                                              #


