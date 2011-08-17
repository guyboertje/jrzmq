module Zapi
  class Zcontext
    attr_reader :sockets,:iothreads,:context
    attr_accessor :linger
    def initialize(io=nil,zapi_ctx=nil)
      if zapi_ctx
        @iothreads = zapi_ctx.iothreads
        @context = zapi_ctx.context
        @shadow = true
      else
        @iothreads = io || 1
        @context = ZMQ::Context.new(@iothreads)
        @shadow = false
      end
      @sockets = []
      @linger = 0
    end

    def shadow?
      @shadow
    end
    
    def destroy
      while @sockets.size > 0 do
        sock = @sockets.shift
        sock.close
      end
    end

    def socket_new(socket_type)
      sock = @context.socket(socket_type)
      @sockets << sock
      sock
    end

    def socket_destroy(socket)
      socket.linger = self.linger
      socket.close
      @sockets.delete(socket)
    end

    def self.shadow(zapi_ctx)
      new(1,zapi_ctx)
    end

  end
end
