class ZMQ
  class Socket
    def recv_string(flags = 0)
      str = recv(flags)
      return nil if str.nil?
      String.from_java_bytes(str)
    end

    def send_string(str,flags = 0)
      send(str.to_java_bytes,flags)
    end

    def more_parts?
      has_receive_more?
    end
    def setsockopt(option_name, option_value, option_len = nil)
      case option_name
      when IDENTITY, SUBSCRIBE, UNSUBSCRIBE
        set_bytes_sockopt(option_name,option_value.to_java_bytes)
      else
        set_long_sockopt(option_name,option_value)
      end
    end

    def getsockopt(option_name)
      case option_name
      when RCVMORE
        has_receive_more?
      when MCAST_LOOP
        has_multicast_loop?
      when IDENTITY
        String.from_java_bytes(identity)
      else
        get_long_sockopt(option_name)
      end
    end
  end
end
