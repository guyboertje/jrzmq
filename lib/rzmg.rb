if RUBY_VERSION < '1.9.0'
  error "This library is only compatible with the 1.9 ruby version"
  exit 255
end

require "zmq"

%W(zmq queue).each do |file|
  require File.join("zmq",file)
end