if RUBY_VERSION =~ /1\.8\.?/
  puts "You might have trouble using this library without proper threading support"
end

require "zmq"

require File.join("zmq","zmq")
require File.join("common","queue")
