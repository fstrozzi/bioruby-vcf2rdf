module BioVcf2rdf

	class Parser
		def initialize(file)
			@file = File.open(file)
		end

		def traverse
			samples = nil
			rdf = Rdfizer.new
			rdf.prefix
			index = 0
			@file.each do |line|
				line.chomp!
				if line.start_with? "#CHROM"
					samples = line.split("\t").slice(9,line.size)
				elsif !line.start_with? "#"
					record = line.split("\t")
					vcf = record.slice(0,6)
					vcf[2] = "VAR-#{index}" if vcf[2] == "."
					vcf << parse_genotypes(record.slice(9,record.size),samples)
					rdf.convert(vcf)
					index += 1
					puts "Record converted: #{index}" if index % 10000 == 0
				end
			end
			puts "Total record: #{index}"
			rdf.close
		end	

		def parse_genotypes(genotypes,samples)
			Hash[samples.zip(genotypes)]
		end

	end


	
	
end
