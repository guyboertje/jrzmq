source "http://rubygems.org"

gemspec

platform :jruby do
  deps = ['zmq','rjb']
  @dependencies.delete_if {|d| deps.include?(d.name)}
end

#gem 'zmq', :git => 'https://guyboertje@github.com/guyboertje/rbzmq.git'
