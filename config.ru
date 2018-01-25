require_relative './app/app'
require_relative './app/models/database_setup'


run BookMarkManager

ENV['RACK_ENV'] ||= 'development'
# database_setup
