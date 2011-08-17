namespace :gem do

  desc "Install the gem locally"
  task :install do
    sh "gem build jrzmq.gemspec"
    sh "gem install jrzmq-*.gem"
    sh "rm jrzmq-*.gem"
  end

end
