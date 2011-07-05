module ZMQ

  module Settings
    def self.context
      @settings_ctx ||= Context.new(1)
    end
  end

  class Socket
    # for version 3
    # BACKLOG RECONNECT_IVL RECONNECT_IVL_MAX RECOVERY_IVL_MSEC
    def affinity= arg
      setsockopt ZMQ::AFFINITY,arg
    end
    def hwm= arg
      setsockopt ZMQ::HWM,arg
    end
    def identity= arg
      setsockopt ZMQ::IDENTITY,arg
    end
    def linger= arg
      setsockopt ZMQ::LINGER,arg
    end
    def rate= arg
      setsockopt ZMQ::RATE,arg
    end
    def receive_buffer_size= arg
      setsockopt ZMQ::RCVBUF,arg
    end
    def recovery_interval= arg
      setsockopt ZMQ::RECOVERY_IVL,arg
    end
    def send_buffer_size= arg
      setsockopt ZMQ::SNDBUF,arg
    end
    def swap= arg
      setsockopt ZMQ::SWAP,arg
    end

    def affinity
      getsockopt ZMQ::AFFINITY
    end
    def hwm
      getsockopt ZMQ::HWM
    end
    def identity
      getsockopt ZMQ::IDENTITY
    end
    def linger
      getsockopt ZMQ::LINGER
    end
    def rate
      getsockopt ZMQ::RATE
    end
    def receive_buffer_size
      getsockopt ZMQ::RCVBUF
    end
    def recovery_interval
      getsockopt ZMQ::RECOVERY_IVL
    end
    def send_buffer_size
      getsockopt ZMQ::SNDBUF
    end
    def swap
      getsockopt ZMQ::SWAP
    end
    def events
      getsockopt ZMQ::EVENTS
    end
    def fd
      getsockopt ZMQ::FD
    end
    def type
      getsockopt ZMQ::TYPE
    end

    def multicast_loop= flag
      return if ZMQ.version.first > 2
      setsockopt ZMQ::MCAST_LOOP, (flag ? 1 : 0)
    end
    def multicast_loop?
      getsockopt ZMQ::MCAST_LOOP
    end

    def has_receive_more?
      0 != getsockopt(ZMQ::RCVMORE)
    end
    alias :more_parts? :has_receive_more?

    def subscribe topic
      setsockopt ZMQ::SUBSCRIBE, topic
    end
    def unsubscribe topic
      setsockopt ZMQ::UNSUBSCRIBE, topic
    end
  end
end
