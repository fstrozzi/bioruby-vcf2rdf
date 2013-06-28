module BioVcf2rdf

	class Parser
		def initialize(file,species)
			@file = File.open(file)
			@species = species 
		end

		def traverse
			samples = nil
			rdf = Rdfizer.new(@species)
			rdf.prefix
			index = 0
			puts "\nRecord converted: "
			@file.each do |line|
				line.chomp!
				if line.start_with? "#CHROM"
					samples = line.split("\t").slice(9,line.size)
				elsif !line.start_with? "#"
					record = line.split("\t")
					vcf = Vcf.new(record.slice(0,8),index)
					vcf.genotype = parse_genotypes(record.slice(9,record.size),samples)	
					rdf.convert(vcf)
					index += 1
					if index % 10000 == 0
						print "\r#{index}"
					end
				end
			end
			puts "\nTotal record converted: #{index}"
			rdf.close
		end	

		def parse_genotypes(genotypes,samples)
			Hash[samples.zip(genotypes)]
		end

	end


	
	
end
