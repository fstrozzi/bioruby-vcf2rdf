# Please require your code below, respecting the naming conventions in the
# bioruby directory tree.
#
# For example, say you have a plugin named bio-plugin, the only uncommented
# line in this file would be 
#
#   require 'bio/bio-plugin/plugin'
#
# In this file only require other files. Avoid other source code.

# Load consequence ontology yaml
require 'yaml'

CONSEQUENCES = YAML.load_file(File.expand_path(File.dirname(File.dirname(__FILE__))+"/sequence_ontologies.yml"))
GENOTYPES = YAML.load_file(File.expand_path(File.dirname(File.dirname(__FILE__))+"/genotype_ontologies.yml"))

require 'uuid'
require 'bio-vcf2rdf/parser'
require 'bio-vcf2rdf/vcf'
require 'bio-vcf2rdf/rdfizer'


