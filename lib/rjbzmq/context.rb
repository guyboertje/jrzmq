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
end


