#! /usr/bin/env jruby

spec = Gem::Specification.new do |s|
  s.name = 'jzmq'
  s.version = '0.0.7'
  s.authors = ['Guy Boertje']
  s.email = 'gboertje@gowebtop.com'
  s.date = '2011-04-25'
  s.summary = 'A wrapper for the java jni zmq jar or the zmq rubygem'
  s.description = "For jruby require 'jzmq' and for MRI 1.9 require 'rzmq'"
  s.homepage = nil
  s.require_path = 'lib'
  s.files = ["Rakefile","Readme.rdoc","lib/jzmq/zmq.jar","lib/jzmq.rb",
  "lib/jzmq/context.rb","lib/jzmq/exception.rb","lib/jzmq/socket.rb",
  "lib/jzapi/context.rb","lib/jzapi/clock.rb","lib/jzapi/message.rb","lib/jzapi/thread.rb",
  "ext_bin/libjzmq.so.0.0.0"]
  s.test_files = []
  s.has_rdoc = false
end
