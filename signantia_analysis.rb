#!/usr/bin/env ruby

require_relative 'lib/signantia_analysis'

puts "signantia_analysis"

# set up database                                                              #

DataMapper::Logger.new(
  STDOUT,
  :debug
  )

DataMapper.setup(
  :default,
  ENV['DATABASE_URL'] || 'sqlite:db/development.sqlite3'
  )

DataMapper.finalize

DataMapper.auto_upgrade!

#                                                                              #


