if RUBY_PLATFORM =~ /java/
  error "This library is not compatible with a java-based ruby environment like JRuby."
  exit 255
end
begin
  require 'rjb'
rescue LoadError
  error "Gem Rjb is required"
  exit 255
end

Rjb::load(classpath = './jars/zmq.jar', jvmargs=[])

JZMQ = Rjb::import('org.zeromq.ZMQ')
JZMQQueue = Rjb::import('org.zeromq.ZMQQueue')

#exception
%W[context socket].each do |file|
  require File.join('.',"rjbjzmq",file)
end

module ZMQ
  NOBLOCK = JZMQ.NOBLOCK
  DONTWAIT = 1
  SNDMORE = JZMQ.SNDMORE
  PAIR = JZMQ.PAIR
  PUB = JZMQ.PUB
  SUB = JZMQ.SUB
  REQ = JZMQ.REQ
  REP = JZMQ.REP
  XREQ = JZMQ.XREQ
  XREP = JZMQ.XREP
  PULL = JZMQ.PULL
  PUSH = JZMQ.PUSH
end