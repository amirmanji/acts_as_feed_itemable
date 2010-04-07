require 'rubygems'
require 'test/unit'
require 'active_record'
require File.dirname(__FILE__) + '/../rails/init.rb'
require 'models'

def load_schema
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
  load(File.dirname(__FILE__) + "/schema.rb")
end