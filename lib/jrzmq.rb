
require 'java'

require File.join("jars","zmq.jar")

ZMQ = Java::OrgZeromq::ZMQ
ZMQQueue = Java::OrgZeromq::ZMQQueue

%W(context socket exception).each do |file|
  require File.join("jzmq",file)
end

%W(clock context message thread).each do |file|
  require File.join("jzapi",file)
end