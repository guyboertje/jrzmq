class ZMQQueue
  attr_reader :poller, :in_sock, :out_sock

  def initialize(context, in_sock, out_sock)
    @in_sock = in_sock;
    @out_sock = out_sock;
    @poller = context.poller(2);
    @poller.register in_sock, ZMQ::POLLIN
    @poller.register out_sock, ZMQ::POLLIN
  end

  def run()
    until Thread.current[:stop] do
      begin
        next if @poller.poll(500_000) < 1
        
        if @poller.pollin(0)
          begin
            part = @in_sock.recv_string
            more = @in_sock.more_parts?
            @out_sock.send_string(part, more ? ZMQ::SNDMORE : 0) unless part.nil?
          end until !more
        end

        if @poller.pollin(1)
          begin
            part = @out_sock.recv_string
            more = @out_sock.more_parts?
            @in_sock.send_string(part, more ? ZMQ::SNDMORE : 0) unless part.nil?
          end until !more
        end
      rescue => e
        Thread.current[:queue_exception] = e
        Thread.current[:stop] = true
      end
    end
    @poller.unregister @in_sock
    @poller.unregister @out_sock
  end
end
