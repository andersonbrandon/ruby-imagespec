require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the image_spec plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the image_spec plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ImageSpec'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "ruby-imagespec"
    gemspec.summary = "Image/Flash extract width/height dimensions extractor"
    gemspec.description = "A lightweight module designed to extract the width/height dimensions of various image types. Also supports SWFs."
    gemspec.email = "dimitrij@blacksquaremedia.com"
    gemspec.homepage = "http://github.com/dim/ruby-imagespec"
    gemspec.authors = [
      "Brandon Anderson",
      "Michael Sheakoski",
      "Mike Boone",
      "Dimitrij Denissenko"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
