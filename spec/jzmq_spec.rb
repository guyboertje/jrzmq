require "spec_helper"

describe 'Zmq wrapper functions' do
  it 'should should send and receive a message' do
    address = "inproc://spec_test"
    in_sock = CTX.socket(ZMQ::PULL)
    out_sock = CTX.socket(ZMQ::PUSH)
    in_sock.bind(address)
    out_sock.connect(address)
    out_sock.send_string("testing 123")
    ret = in_sock.recv_string
    ret.should == "testing 123"
    in_sock.close
    out_sock.close
  end


end
