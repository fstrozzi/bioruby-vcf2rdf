# bio-vcf2rdf

[![Build Status](https://secure.travis-ci.org/fstrozzi/bioruby-vcf2rdf.png)](http://travis-ci.org/fstrozzi/bioruby-vcf2rdf)

Simple converter from VCF 4.1 format to RDF turtle format.

For ontologies:

* It uses [FALDO](https://github.com/JervenBolleman/FALDO#known-positions) ExactPosition to describe locations 
* A simple ontology to describe variation properties:
	* <http://genome.db/var/referenceAllele> : Literal for the reference allele base
	* <http://genome.db/var/alternativeAllele> : Literal for the alternative allele base (or bases for InDel)
	* <http://genome.db/var/quality> : xsd:float for quality score
	* <http://genome.db/var/effect> : Literal for the variation effect on annotated genes (using SO)
	* <http://genome.db/var/hasGenotype> : Literal for the genotype description for a particular sample (i.e. "0/0" "0/1" "1/1" "1/2")
	* <http://genome.db/var/referenceAlleleCoverage> : xsd:int for reference allele coverage
	* <http://genome.db/var/alternativeAlleleCoverage> : xsd:int for alternative allele coverage

Note: this software is under active development!

## Installation

```sh
    gem install bio-vcf2rdf
```

## Usage

```ruby
    require 'bio-vcf2rdf'
```

The API doc is online. For more code examples see the test files in
the source tree.
        
## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/fstrozzi/bioruby-vcf2rdf

The BioRuby community is on IRC server: irc.freenode.org, channel: #bioruby.

## Cite

If you use this software, please cite one of
  
* [BioRuby: bioinformatics software for the Ruby programming language](http://dx.doi.org/10.1093/bioinformatics/btq475)
* [Biogem: an effective tool-based approach for scaling up open source software development in bioinformatics](http://dx.doi.org/10.1093/bioinformatics/bts080)

## Biogems.info

This Biogem is published at [#bio-vcf2rdf](http://biogems.info/index.html)

## Copyright

Copyright (c) 2013 Francesco Strozzi. See LICENSE.txt for further details.

