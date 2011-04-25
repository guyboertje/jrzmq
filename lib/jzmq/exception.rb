#Seems like the Java::OrgZeromq::ZMQException class is not reopenable

class ZMQ
  ZeroMQError = Class.new(Java::OrgZeromq::ZMQException)
=begin
  class ZeroMQError < Java::OrgZeromq::ZMQException
    def einval?() org.zeromq.ZMQ::Error::EINVAL.code == error_code; end
    def eterm?() org.zeromq.ZMQ::Error::ETERM.code == error_code; end
    def efault?() org.zeromq.ZMQ::Error::EFAULT.code == error_code; end
    def egain?() org.zeromq.ZMQ::Error::EAGAIN.code == error_code; end
    def enocompatproto?() org.zeromq.ZMQ::Error::ENOCOMPATPROTO.code == error_code; end
    def eprotonosupport?() org.zeromq.ZMQ::Error::EPROTONOSUPPORT.code == error_code; end
    def eaddrinuse?() org.zeromq.ZMQ::Error::EADDRINUSE.code == error_code; end
    def eaddrnotavail?() org.zeromq.ZMQ::Error::EADDRNOTAVAIL.code == error_code; end
    def einval?() org.zeromq.ZMQ::Error::EINVAL.code == error_code; end
    def efsm?() org.zeromq.ZMQ::Error::EFSM.code == error_code; end
    def enotsup?() org.zeromq.ZMQ::Error::ENOTSUP.code == error_code; end
    def emthread?() org.zeromq.ZMQ::Error::EMTHREAD.code == error_code; end
  end
=end
end
