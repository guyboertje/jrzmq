module ZMQ

  module Settings
    def self.context
      @settings_ctx ||= Context.new(1)
    end
  end
  
  class Socket
    # for version 3
    #%W[BACKLOG RECONNECT_IVL RECONNECT_IVL_MAX RECOVERY_IVL_MSEC]
    consts = %W[AFFINITY HWM IDENTITY LINGER RATE RCVBUF RECOVERY_IVL SNDBUF SWAP]
    functs = %W[affinity hwm identity linger rate receive_buffer_size recovery_interval send_buffer_size swap]
    a = consts.zip(functs).flatten
    until a.empty? do
      cons, meth = a.shift(2)
      define_method(meth + "=") { |arg| setsockopt(ZMQ.const_get(cons),arg) }
    end

    getters = consts + %W[EVENTS FD TYPE]
    getfunc = functs + %W[events fd type]
    a = getters.zip(getfunc).flatten
    until a.empty? do
      cons, meth = a.shift(2)
      define_method(meth) { getsockopt(ZMQ.const_get(cons)) }
    end

    def multicast_loop=(flag)
      return if ZMQ.version.first > 2
      setsockopt(ZMQ::MCAST_LOOP, flag ? 1 : 0)
    end
    def multicast_loop?
      getsockopt(ZMQ::MCAST_LOOP)
    end

    def has_receive_more?
      getsockopt(ZMQ::RCVMORE) != 0
    end
    alias :more_parts? :has_receive_more?

    def subscribe(topic)
      setsockopt(ZMQ::SUBSCRIBE, topic)
    end
    def unsubscribe(topic)
      setsockopt(ZMQ::UNSUBSCRIBE, topic)
    end
  end
end
