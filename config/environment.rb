require 'bundler/setup'
Bundler.require

Dir["../lib/*.rb"].each {|file| require file }