module Zapi
  class Zmessage < Array
    attr_reader :error

    def initialize(*parts)
      if parts[0].kind_of? Fixnum
        super(*parts)
      else
        super()
        unshift(*parts) unless parts.empty?
      end
      @error = false
    end

    def multiple?
      size > 1
    end

    def self.read(socket)
      m = new
      m.read socket
    end

    def read(socket)
      clear
      loop do
        part = socket.recv_string
        if part.nil?
          @error = true
          clear
          break
        end
        push part
        break unless socket.more_parts?
      end
      self
    end

    def write(socket)
      while size > 1 do
        part = shift
        socket.send_string part, ZMQ::SNDMORE
      end
      socket.send_string shift()
    end
  end
end
