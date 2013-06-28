module BioVcf2rdf

	
	class Rdfizer
		
		def initialize(out = "vcf.ttl",species)
			@out = java.io.FileWriter.new(out)
			@random = java.util.Random.new
			@species = species
		end

		def prefix
			@out.write("@prefix ngs: <http://genome.db/ngs/> .\n")
			@out.write("@prefix var: <http://genome.db/var/> .\n")
			@out.write("@prefix sample: <http://genome.db/sample/> .\n")
			@out.write("@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n")
			@out.write("@prefix faldo: <http://biohackathon.org/resource/faldo#> .\n")
		end

		def convert(vcf)
			@out.write("var:#{vcf.id} a faldo:ExactPosition;\n")
			@out.write("\tfaldo:position \"#{vcf.position}\"^^xsd:int ;\n")
			@out.write("\tfaldo:reference <http://beta.rest.ensembl.org/sequence/region/#{@species}/#{vcf.chromosome}> .\n")
			@out.write("var:#{vcf.id} var:referenceAllele \"#{vcf.ref}\" .\n")
			@out.write("var:#{vcf.id} var:alternativeAllele \"#{vcf.alt}\" .\n")
			@out.write("var:#{vcf.id} var:quality \"#{vcf.quality}\"^^xsd:float .\n")
			@out.write("var:#{vcf.id} var:effect \"#{vcf.effect}\" .\n") unless vcf.effect.nil?
			vcf.genotype.each_pair do |sample,genotype|
				uuid = "uuid-"+get_uuid
				genotype_info = genotype.split(":")
				@out.write("var:#{vcf.id} var:uuid var:#{uuid} .\n")
				@out.write("sample:#{sample} ngs:hasVariation var:#{uuid} .\n")
				@out.write("var:#{uuid} var:hasGenotype \"#{genotype_info[0]}\".\n")
				@out.write("var:#{uuid} var:referenceAlleleCoverage \"#{genotype_info[1].split(",")[0]}\"^^xsd:int .\n")
				@out.write("var:#{uuid} var:alternativeAlleleCoverage \"#{genotype_info[1].split(",")[1]}\"^^xsd:int .\n")
			end
		end

		def close
			@out.close
		end

	private

		def get_uuid
			java.util.UUID.new(@random.nextLong(),@random.nextLong()).to_s	
		end

		

	end

end

