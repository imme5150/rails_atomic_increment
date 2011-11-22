Gem::Specification.new do |s|
  s.name              = "rails_atomic_increment"
  s.version           = "0.2"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Josh Shupack"]
  s.email             = ["yNaught@gmail.com"]
  s.homepage          = "http://github.com/imme5150/rails_atomic_increment"
  s.summary           = "Adds atomic_increment! and atomic_decrement! to ActiveRecord models"
  s.description       = "Allows you to use atomic inrement and decriment from the model instead of having to call the class.  Much more object oriented"
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.6"
  
  # If you have runtime dependencies, add them here
  s.add_runtime_dependency "rails", "> 2"
  
  # If you have development dependencies, add them here
  # s.add_development_dependency "another", "= 0.9"

  # The list of files to be contained in the gem
  s.files         = `git ls-files`.split("\n")
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  s.require_path = 'lib'
end
