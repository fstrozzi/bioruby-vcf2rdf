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
	
	desc "Download SO variation consequence terms and generate a YAML"
	task "ensembl" do
		require 'nokogiri'
		require 'open-uri'
		require 'yaml'
		page = Nokogiri::HTML(open("http://ensembl.org/info/docs/variation/predicted_data.html"))
		content = []
		page.xpath('//table[@id="consequence_type_table"]').each {|row| content = row.content}
		ontologies = []
		content.split("\n\n\n").slice(1,content.size).each do |row| 
			r = row.split("\n\t")
			ontologies << [r[0].tr("\t",''),r[2]]
		end
		ontologies << ["uri","http://www.sequenceontology.org/miso/current_release/term/"]
		out = File.open("consequence_ontologies.yml","w")
		out.write(YAML.dump(Hash[ontologies]))
	end


end

