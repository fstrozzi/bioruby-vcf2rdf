# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "bio-vcf2rdf"
  gem.homepage = "http://github.com/fstrozzi/bioruby-vcf2rdf"
  gem.license = "MIT"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "francesco.strozzi@gmail.com"
  gem.authors = ["Francesco Strozzi"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bio-vcf2rdf #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


namespace "ontology" do

	desc "Generate SO yaml from OBO"
	task :convert, :file do |t,args|
		out = {}
		f = File.open(args[:file])
		f.each do |line|
			f.readline("[Term]\n")
			unless f.eof
				so = f.readline("\n").chomp.split(": ")[-1]
				term = f.readline("\n").chomp.split(": ")[-1]
				out[term] = so
			end
		end
		out['uri'] = "http://purl.org/obo/owl/SO#"
		File.open("sequence_ontologies.yml","w") {|y| y.write(out.to_yaml)}
	end

	desc "generate RDF turtle of sequence ontology yaml"
	task :rdf do
		so = YAML.load_file("sequence_ontologies.yml")
		out = File.open("sequence_ontologies.ttl","w")
		out.write("@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n")
		out.write("@prefix so: <#{so["uri"]}> .\n")
		so.each_pair do |term,id|
			out.write("so:#{id} rdfs:label \"#{term}\" .\n") unless term == "uri"
		end
		out.close()
	end




end



