class ZMQ
  class Context
    def self.new(*args)
       ZMQ.context(args.first || 1)
    end
    def initialize(*args)
    end
    def terminate
      term
    end
    def close
      term
    end
  end
end
