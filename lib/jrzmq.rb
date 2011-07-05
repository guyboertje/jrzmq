
require 'java'

require File.join("jars","zmq.jar")

ZMQ = Java::OrgZeromq::ZMQ
#ZMQQueue = Java::OrgZeromq::ZMQQueue

%W(context socket exception).each do |file|
  require File.join("jzmq",file)
end

require File.join("common","queue")

%W(clock context message thread).each do |file|
  require File.join("jzapi",file)
end

class ZMQ
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
