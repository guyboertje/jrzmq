Jsys = java.lang.System unless defined? Jsys

module Zapi
  KILO = 1000.0
  MEGA = 1000000.0
  class Zclock #deals with everything in milliseconds
    def self.current_milli
      (Jsys.nano_time / MEGA).to_i
    end
    
    def self.now
      (Jsys.nano_time / MEGA).to_i
    end

    def self.advance_to(future_msec)
      (Jsys.nano_time / MEGA).to_i + future_msec
    end

    def self.sleep(millisecs)
      Kernel.sleep((millisecs) / KILO)
    end

    def self.stopwatch(*args)
      return unless block_given?
      start = Jsys.nano_time
      yield(*args)
      stop = Jsys.nano_time
      delta = ((stop - start) / KILO).to_i
      delta / KILO
    end
  end
end

