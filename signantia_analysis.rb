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
    "The database URI - e.g. sqlite:db/example.sqlite3"
    ) do |database|
    options[:database] = database
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

#                                                                              #


