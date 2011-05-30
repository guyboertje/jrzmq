require "spec_helper"

include Zapi

describe 'Zmq api clock features' do
  it 'should give the current msec timestamp' do
    Zclock.now.class.should == Fixnum
    Zclock.current_milli.class.should == Fixnum
  end

  it 'should give future msec timestamp' do
    delta = Zclock.advance_to(10000) - Zclock.now
    delta.should be_between(9998, 10002) #account for jitter
  end

  it 'should sleep the current thread' do
    t = Zclock.now; Zclock.sleep(200); delta = Zclock.now - t
    delta.should == be_between(200, 202) #account for threading delays
  end

  it 'should time a long running block' do
    delta = Zclock.stopwatch { sleep(1.5) }
    delta.should be_between(1499.5, 1500.5) #account for threading delays
  end
end

describe "Zmessage" do
  it "should create a new empty message" do
    msg = Zmessage.new
    msg.to_a.should == []
  end

  it "should create a single part message" do
    msg = Zmessage.new("Hello World")
    msg.multiple?.should be_false
    msg.shift.should == "Hello World"
  end

  it "should add/remove extra parts to the message" do
    msg = Zmessage.new("Hello")
    msg << "World"
    msg.multiple?.should be_true
    msg.to_a.join.should == "HelloWorld"
    a,b = msg.shift(2)
    a.should == "Hello"
    b.should == "World"
  end

  it "should add extra parts to the message" do
    msg = Zmessage.new
    msg.unshift("Hello","World")
    msg.multiple?.should be_true
    msg.to_a.join.should == "HelloWorld"
    msg.push("nice","to")
    msg << "meet" << "you"
    msg.to_a.should == %W[Hello World nice to meet you]
  end

  it "should create message and append parts in one line" do
    msg = Zmessage.new("hello","world")
    msg[1].should == "world"
  end
end

describe 'Zcontext' do
  it "should create a wrapped context" do
    ctx = Zcontext.new
    ctx.context.should_not be_nil
    ctx.iothreads.should == 1
    ctx.sockets.should == []
    ctx.shadow?.should be_false
  end

  it "should create a socket" do
    ctx = Zcontext.new
    sock = ctx.socket_new(ZMQ::REQ)
    ctx.sockets.size.should == 1
    sock.kind_of?(ZMQ::Socket).should be_true
    sock.respond_to?(:hwm=).should be_true
  end

  it "should destroy a socket" do
    ctx = Zcontext.new
    sock = ctx.socket_new(ZMQ::REQ)
    ctx.sockets.size.should == 1
    ctx.socket_destroy(sock)
    ctx.sockets.size.should == 0
  end

  it "should create a shadow context" do
    ctx = Zcontext.new
    stx = Zcontext.shadow(ctx)
    stx.context.should_not be_nil
    stx.iothreads.should == 1
    stx.sockets.should == []
    stx.shadow?.should be_true
  end
end

describe "Zthread" do
  it "should create a new communicable thread" do
    ctx = Zcontext.new
    pipe = Zthread.fork(ctx) do |ctx, pipe, args|
      while (msg = Zmessage.read(pipe))[0].upcase != "STOP" do
        msg[0].reverse!
        msg.write(pipe)
      end
      ctx.destroy 
    end
    pipe.kind_of?(ZMQ::Socket).should be_true
    pipe.respond_to?(:hwm).should be_true
    pipe.send_string("hello")
    reply = pipe.recv_string
    reply.should == "olleh"
    pipe.send_string("stop")
  end
end
