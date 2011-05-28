module Zapi
  class Zthread
    def self.fork(zapi_ctx,args={},&block)
      raise "Required block is missing" if block.nil?
      raise "Must use the Zapi::Zcontext class for context" unless zapi_ctx.is_a?(Zcontext)
      pipe = zapi_ctx.socket_new(ZMQ::PAIR)
      pipe.hwm = 1
      endpoint = "inproc://zctx-pipe-#{pipe.object_id}"
      pipe.bind(endpoint)

      _ctx = Zcontext.shadow(zapi_ctx)
      _pipe = _ctx.socket_new(ZMQ::PAIR)
      _pipe.hwm = 1
      _pipe.connect(endpoint)
      Thread.new(_ctx,_pipe,args,&block)
      pipe
    end
  end
end
