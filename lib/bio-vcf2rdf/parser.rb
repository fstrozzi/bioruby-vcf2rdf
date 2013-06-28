module BioVcf2rdf

	class Parser
		def initialize(file,species)
			@file = File.open(file)
			@species = species 
		end

		def traverse(out="vcf.ttl")
			out = File.open(out,"w")
			samples = nil
			rdf = Rdfizer.new(@species)
			out.write rdf.prefix
			index = 0
			puts "\nRecord converted: "
			@file.each do |line|
				line.chomp!
				if line.start_with? "#CHROM"
					samples = get_samples(line)
				elsif !line.start_with? "#"
					index += 1
					vcf = Vcf.new(line,samples,index)
					out.write rdf.convert(vcf)
					if index % 10000 == 0
						print "\r#{index}"
					end
				end
			end
			puts "\nTotal record converted: #{index}"
			out.close
		end	

	private

		def get_samples(line)
			line.split("\t").slice(9,line.size)	
		end

	end


	
	
end
