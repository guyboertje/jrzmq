unless RUBY_PLATFORM =~ /java/
  error "This library is only compatible with a java-based ruby environment like JRuby."
  exit 255
end

require 'java'

###
#   This a jruby convenience library to use the JNI based zmq java classes.
#   It also tries to be a drop in replacement for ffi-zmq
###
require File.join("jzmq","zmq.jar")

ZMQ = Java::OrgZeromq::ZMQ

%W(context socket exception).each do |file|
  require File.join("jzmq",file)
end
