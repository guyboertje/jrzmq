module ZMQ

  class Context
    def initialize(*args)
      @ctx = JZMQ.context(args.first || 1)
    end

    def term
      @ctx.term
    end
    alias :terminate :term
    alias :close :term

    def socket(kind)
      Socket.construct(@ctx, kind)
    end

    def poller(slots=32)
      Poller.construct(@ctx, slots)
    end
  end

  class Poller
    private_class_method :new
    def self.construct(ctx,slots=32)
      new(ctx,slots)
    end

    def initialize(ctx,slots)
      @poller = ctx.poller(slots)
    end

    def next
      @poller.getNext
    end

    def size
      @poller.getSize
    end

    def socket(slot)
      @poller.getSocket(slot)
    end

    def poll(timeout)
      @poller.poll timeout
    end

    def pollerr(slot)
      @poller.pollerr slot
    end
    def pollin(slot)
      @poller.pollin slot
    end
    def pollout(slot)
      @poller.pollout slot
    end

    def register(skt, events = -1)
      if events < 0
        @poller.register(skt.socket)
      else
        @poller.register(skt.socket, events)
      end
    end
    def unregister(skt)
      @poller.unregister(skt.socket)
    end
  end
end


