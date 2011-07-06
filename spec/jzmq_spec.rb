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

  it 'should poll for incoming messages' do
    address = "inproc://spec_test"
    out_sock = CTX.socket(ZMQ::PUSH)
    out_sock.bind(address)
    in_sock = CTX.socket(ZMQ::PULL)
    in_sock.connect(address)
    poll = CTX.poller
    poll.register(in_sock, ZMQ::POLLIN)

    out_sock.send_string("testing 123")
    fib = Fiber.new do
      ret = ""
      Fiber.yield
      evts = poll.poll(500_000)
      if poll.pollin(0)
        ret = in_sock.recv_string
      end
      ret
    end
    fib.resume
    out_sock.send_string("testing 123")
    res = fib.resume
    poll.unregister(in_sock)
    in_sock.close
    out_sock.close
    res.should == "testing 123"
  end

end
