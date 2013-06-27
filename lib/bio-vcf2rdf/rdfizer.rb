module BioVcf2rdf

	
	class Rdfizer
		
		def initialize(out = "vcf.ttl")
			@out = java.io.FileWriter.new(out)
			@random = java.util.Random.new
		end

		def prefix
			@out.write("@prefix ngs: <http://genome.db/ngs/> .\n")
			@out.write("@prefix var: <http://genome.db/var/> .\n")
			@out.write("@prefix sample: <http://genome.db/sample/> .\n")
		end

		def convert(vcf)
			@out.write("var:#{vcf[2]} var:chromosome \"#{vcf[0]}\" .\nvar:#{vcf[2]} var:position #{vcf[1]} .\nvar:#{vcf[2]} var:referenceAllele \"#{vcf[3]}\" .\nvar:#{vcf[2]} var:alternativeAllele \"#{vcf[4]}\" .\nvar:#{vcf[2]} var:quality #{vcf[5]} .\n")
			vcf[6].each_pair do |sample,genotype|
				uuid = "uuid-"+get_uuid
				genotype_info = genotype.split(":")
				@out.write("var:#{vcf[2]} var:uuid var:#{uuid} .\nsample:#{sample} ngs:hasVariation var:#{uuid} .\nvar:#{uuid} var:hasGenotype \"#{genotype_info[0]}\".\nvar:#{uuid} var:referenceAlleleCoverage #{genotype_info[1].split(",").first} .\nvar:#{uuid} var:alternativeAlleleCoverage #{genotype_info[1].split(",")[1]} .\n")
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

