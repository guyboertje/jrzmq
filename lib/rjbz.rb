if RUBY_VERSION < "1.9.0"
  puts "You might have trouble using this library without proper threading support"
end

begin
  require 'rjb'
rescue LoadError
  error "Gem Rjb is required"
  exit 255
end

LIB_ROOT = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR

Rjb::load(classpath = File.join(LIB_ROOT,"jars","zmq.jar"), jvmargs=[])

JZMQ = Rjb::import('org.zeromq.ZMQ')

#exception
%W[context socket].each do |file|
  require File.join(LIB_ROOT,"rjbzmq",file)
end

require File.join(LIB_ROOT,"common","queue")

module ZMQ
  def self.version
    [JZMQ.version_major, JZMQ.version_minor, JZMQ.version_patch]
  end

  HWM = 1
  SWAP = 3
  AFFINITY = 4
  IDENTITY = 5
  SUBSCRIBE = 6
  UNSUBSCRIBE = 7
  RATE = 8
  RECOVERY_IVL = 9
  MCAST_LOOP = 10
  SNDBUF = 11
  RCVBUF = 12
  RCVMORE = 13
  FD = 14
  EVENTS = 15
  TYPE = 16
  LINGER = 17

  POLLIN = 1
  POLLOUT = 2
  POLLERR = 4

  NOBLOCK = 1
  DONTWAIT = 1
  SNDMORE = 2
  PAIR = 0
  PUB = 1
  SUB = 2
  REQ = 3
  REP = 4
  XREQ = 5
  DEALER = 5
  XREP = 6
  ROUTER = 6
  PULL = 7
  PUSH = 8

  module Settings
    def self.context
      @settings_ctx ||= Context.new(1)
    end
  end
end
