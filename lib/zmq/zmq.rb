module ZMQ
  class Socket
    # for version 3
    #%W[BACKLOG RECONNECT_IVL RECONNECT_IVL_MAX RECOVERY_IVL_MSEC]

    setters = %W[AFFINITY HWM IDENTITY LINGER RATE RCVBUF RECOVERY_IVL SNDBUF SWAP]
    setfunc = %W[affinity= hwm= identity= linger= rate= receive_buffer_size= recovery_interval= send_buffer_size= swap=]
    a = setters.zip(setfunc)
    until a.empty? do
      cons,meth = a.shift(2)
      define_method(meth.to_sym) { |arg| setsockopt(ZMQ.const_get(cons),arg) }
    end

    getters = %W[AFFINITY EVENTS FD HWM IDENTITY LINGER RATE RCVBUF RECOVERY_IVL SNDBUF SWAP TYPE]
    getfunc = %W[affinity events fd hwm identity linger rate receive_buffer_size recovery_interval send_buffer_size swap type]
    a = setters.zip(setfunc)
    until a.empty? do
      cons,meth = a.shift(2)
      define_method(meth.to_sym) { getsockopt(ZMQ.const_get(cons)) }
    end

    def multicast_loop=(flag)
      return if ZMQ.version.first > 2
      setsockopt(ZMQ::MCAST_LOOP, flag ? 1 : 0)
    end
    def multicast_loop?
      getsockopt(ZMQ::MCAST_LOOP)
    end

    def

    %W[SUBSCRIBE UNSUBSCRIBE RCVMORE ]

  end
end

SWAP
