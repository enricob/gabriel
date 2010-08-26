require 'rubygems'

task :default => "build"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "gabriel"
    gemspec.summary = %Q{Bash completion for god}
    gemspec.description = %Q{gabriel helps you communicate with god by giving you bash completions for commands, options, tasks, and groups}
    gemspec.email = "enricob@gmail.com"
    gemspec.homepage = "http://github.com/enricob/gabriel"
    gemspec.authors = ["Enrico Bianco"]
    gemspec.executables = ["gabriel-install"]
    gemspec.files = ["README.md", "LICENSE", "VERSION", "install", "bin/*", "scripts/*"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
