$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

%W(jzmq).each do |lib|
  require lib
end

require "rspec"
require "fiber"
puts "if you get an error about Fiber then run jruby in --1.9 mode"

RSpec.configure do |config|
  config.before(:suite) do
    CTX = ZMQ::Context.new 1
  end

  config.after(:suite) do
    CTX.terminate
  end
end