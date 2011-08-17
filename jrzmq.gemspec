#! /usr/bin/env jruby

spec = Gem::Specification.new do |s|
  s.name = 'jrzmq'
  s.version = '0.0.8'
  s.authors = ['Guy Boertje']
  s.email = 'gboertje@gowebtop.com'
  s.date = '2011-04-25'
  s.summary = 'A wrapper for the java jni zmq jar using ruby java bridge if necessary'
  s.description = "just require 'jzmq' and it will load the correct libs"
  s.homepage = nil
  s.require_path = 'lib'
  s.files = %W[Rakefile
               Readme.rdoc
               lib/jzmq.rb
               lib/jars/zmq.jar
               lib/jrzmq.rb
               lib/jzmq/context.rb
               lib/jzmq/exception.rb
               lib/jzmq/socket.rb
               lib/jzapi/context.rb
               lib/jzapi/clock.rb
               lib/jzapi/message.rb
               lib/jzapi/thread.rb
               lib/rbzmq.rb
               lib/zmq/zmq.rb
               lib/common/queue.rb
               ext_bin/libjzmq.so.0.0.0]

  unless RUBY_PLATFORM =~ /java/
    s.add_dependency 'rjb'
  end

  s.test_files = []
  s.has_rdoc = false
end
