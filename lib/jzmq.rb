if RUBY_PLATFORM =~ /java/
  require "jrzmq"
else
  require "rbzmq"
end
