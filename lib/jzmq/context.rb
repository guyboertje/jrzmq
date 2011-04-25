class ZMQ
  class Context
    def self.new(*args)
       ZMQ.context(args.first)
    end
    def initialize(*args)
    end
    def terminate
      term
    end
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
end
