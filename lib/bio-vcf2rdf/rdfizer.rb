module BioVcf2rdf

	
	class Rdfizer
	
		attr_accessor :var_prefix

		def initialize(out = "vcf.ttl",species)
			@random = java.util.Random.new
			@species = species
			@var_prefix = "http://genome.db/var/#{species}/"	
		end

		def prefix
			str = ""
			str << "@prefix ngs: <http://genome.db/ngs/> .\n"
			str << "@prefix var: <#{@var_prefix}> .\n"
			str << "@prefix sample: <http://genome.db/sample/> .\n"
			str << "@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n"
			str << "@prefix faldo: <http://biohackathon.org/resource/faldo#> .\n"
			str << "@prefix so: <#{CONSEQUENCES["uri"]}> .\n"
			str << "@prefix ensregion: <http://beta.rest.ensembl.org/sequence/region/> .\n"
			str << "@prefix ensfeat: <http://beta.rest.ensembl.org/feature/id/> .\n"
			str
		end

		def convert(vcf)
			str = ""
			str << "var:#{vcf.id} a faldo:ExactPosition;\n"
			str << "\tfaldo:position \"#{vcf.position}\"^^xsd:int ;\n"
			str << "\tfaldo:reference ensregion:#{vcf.chromosome} .\n"
			str << "var:#{vcf.id} var:referenceAllele \"#{vcf.ref}\" .\n"
			str << "var:#{vcf.id} var:alternativeAllele \"#{vcf.alt}\" .\n"
			str << "var:#{vcf.id} var:quality \"#{vcf.quality}\"^^xsd:float .\n"
			unless vcf.effect.nil?
				vcf.effect.each_pair do |effect,transcript|
					uuid = "uuid-"+get_uuid
					str << "var:#{vcf.id} var:uuid var:#{uuid} .\n"
					so = CONSEQUENCES[effect]
					raise RuntimeError,"No sequence ontology found with this name: #{effect}" if so.nil?
					str << "var:#{uuid} var:effect so:#{so} .\n"
					str << "var:#{uuid} var:effectOn ensfeat:#{transcript} .\n" unless transcript == ""
				end
			end
			vcf.genotype.each_pair do |sample,genotype|
				uuid = "uuid-"+get_uuid
				genotype_info = genotype.split(":")
				str << "var:#{vcf.id} var:uuid var:#{uuid} .\n"
				str << "sample:#{sample} ngs:hasVariation var:#{uuid} .\n"
				str << "var:#{uuid} var:hasGenotype var:#{GENOTYPES[genotype_info[0]]} ;\n"
				str << "var:referenceAlleleCoverage \"#{genotype_info[1].split(",")[0]}\"^^xsd:int ;\n"
				str << "var:alternativeAlleleCoverage \"#{genotype_info[1].split(",")[1]}\"^^xsd:int .\n"
			end
			str
		end

	private

		def get_uuid
			java.util.UUID.new(@random.nextLong(),@random.nextLong()).to_s	
		end

	end

end

