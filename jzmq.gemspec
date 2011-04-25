#! /usr/bin/env jruby

spec = Gem::Specification.new do |s|
  s.name = 'jzmq'
  s.version = '0.0.2'
  s.authors = ['Guy Boertje']
  s.email = 'gboertje@gowebtop.com'
  s.date = '2011-04-25'
  s.summary = 'A JRuby wrapper for the java jni zmq jar'
  s.description = s.summary
  s.homepage = nil
  s.require_path = 'lib'
  s.files = ["Rakefile","Readme.rdoc",
  "lib/jzmq.rb","lib/jzmq/context.rb","lib/jzmq/exception.rb","lib/jzmq/socket.rb","lib/jzmq/zmq.jar",
  "ext_bin/libjzmq.so.0.0.0"]
  s.test_files = []
  s.has_rdoc = false
end

