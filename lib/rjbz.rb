if RUBY_VERSION =~ /1\.8\.?/
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

  module Settings
    def self.context
      @settings_ctx ||= Context.new(1)
    end
  end
end