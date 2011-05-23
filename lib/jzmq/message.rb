class ZMQ
  class Message
    attr_reader :error
    def initialize
      @buffer = []
      @error = false
    end
    def unshift part
      @buffer.unshift part
    end
    def shift part
      @buffer.shift
    end
    def pop part
      @buffer.pop part
    end
    def push part
      @buffer.push part
    end
    def << part
      @buffer << part
    end
    def [] index
      @buffer[index]
    end
    def []= index, part
      @buffer[index] = part
    end
    def to_a
      @buffer
    end

    def self.read(socket)
      @msg = new
      @msg.read socket
    end

    def read(socket)
      @buffer.clear
      loop do
        part = socket.recv_string
        if part.nil?
          @error = true
          @buffer.clear
          break
        end
        @buffer << part
        break unless socket.more_parts?
      end
      self
    end

    def write(socket)
      while @buffer.size > 1 do
        part = @buffer.shift
        socket.send_string part, ZMQ::SNDMORE
      end
      last = @buffer.shift
      socket.send_string last
    end
  end
end
