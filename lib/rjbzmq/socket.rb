module ZMQ
  class Socket
    private_class_method :new

    def self.construct(context,kind)
      new(context,kind)
    end

    def initialize(ctx,kind)
      @sock = ctx.socket(kind)
    end

    def socket
      @sock
    end

    def close
      @sock.close
    end
    def bind(addr)
      @sock.bind(addr)
    end
    def connect(addr)
      @sock.connect(addr)
    end
    def multicast_loop?
      @sock.hasMulticastLoop()
    end
    def receive_more?
      @sock.hasReceiveMore()
    end
    alias :more_parts? :receive_more?

    def recv_string(flags = 0)
      @sock.recvmsg(flags)
    end
    def send_string(msg,flags = 0)
      @sock.sendmsg(msg, flags)
    end
 # for version 3
    # BACKLOG RECONNECT_IVL RECONNECT_IVL_MAX RECOVERY_IVL_MSEC
    def affinity= arg
      @sock.setAffinity arg
    end
    def hwm= arg
      @sock.setHWM arg
    end
    def identity= arg
      @sock.setIdentity arg
    end
    def linger= arg
      @sock.setLinger arg
    end
    def rate= arg
      @sock.setRate arg
    end
    def receive_buffer_size= arg
      @sock.setReceiveBufferSize arg
    end
    def recovery_interval= arg
      @sock.setRecoveryInterval arg
    end
    def send_buffer_size= arg
      @sock.setSendBufferSize arg
    end
    def swap= arg
      @sock.setSwap arg
    end

    def affinity
      @sock.getAffinity
    end
    def hwm
      @sock.getHWM
    end
    def identity
      @sock.getIdentity
    end
    def linger
      @sock.getLinger
    end
    def rate
      @sock.getRate
    end
    def receive_buffer_size
      @sock.getReceiveBufferSize
    end
    def recovery_interval
      @sock.getRecoveryInterval
    end
    def send_buffer_size
      @sock.getSendBufferSize
    end
    def swap
      @sock.getSwap
    end
    def events
      @sock.getEvents
    end
    def fd
      @sock.getFD
    end
    def type
      @sock.getType
    end

    def multicast_loop= flag
      return if ZMQ.version.first > 2
      @sock.setMulticastLoop (flag ? 1 : 0)
    end

    def subscribe topic
      @sock.subscribe topic
    end
    def unsubscribe topic
      @sock.unsubscribe topic
    end
  end
end
