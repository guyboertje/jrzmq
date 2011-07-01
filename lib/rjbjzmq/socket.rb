module ZMQ
  class Socket
    private_class_method :new

    def self.construct(context,kind)
      new(context,kind)
    end

    def initialize(ctx,kind)
      @sock = ctx.socket(kind)
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
    def recv_string(flags = 0)
      @sock.recv(flags)
    end
    def send_string(msg,flags = 0)
      @sock.send('send', 'send', msg, flags)
    end


  end
end