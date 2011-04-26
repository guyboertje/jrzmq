#Seems like the Java::OrgZeromq::ZMQException class is not reopenable

class ZMQ
  ZeroMQError = Class.new(Java::OrgZeromq::ZMQException)
end
