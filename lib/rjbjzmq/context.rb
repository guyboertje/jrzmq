module ZMQ
  class Context

    def initialize(*args)
      @ctx = JZMQ.context(args.first || 1)
    end

    def term
      @ctx.term
    end
    alias :terminate :term

    def socket(kind)
      Socket.construct(@ctx,kind)
    end

    def poller(size=nil)
      size ? @ctx.poller(size) : @ctx.poller
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

  module Settings
    def self.context
      @settings_ctx ||= Context.new(1)
    end
  end
end