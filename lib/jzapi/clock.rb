Jsys = java.lang.System unless defined? Jsys

class ZMQ
  class Clock
  def self.current_milli
    (Jsys.nano_time / 1_000_000).to_i
  end
  def self.next_expire
    (Jsys.nano_time / 1_000_000).to_i + GLOBAL_TIMEOUT
  end
  def self.next_ping
    (Jsys.nano_time / 1_000_000).to_i + PING_INTERVAL
  end
  def self.next_ttl
    (Jsys.nano_time / 1_000_000).to_i + SERVER_TTL
  end
end
  
