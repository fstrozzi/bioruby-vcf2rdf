module BioVcf2rdf

	class Parser
		def initialize(file,species,chunks)
			@file = File.open(file)
			@species = species
			@chunks = chunks.to_i
		end

		def traverse(file_out="vcf")
			n_chunk = 1
			out = File.open(file_out+"_#{n_chunk}.ttl","w")
			samples = nil
			rdf = Rdfizer.new(@species)
			out.write rdf.prefix
			index = 0
			puts "\nConversion progress: "
			vcf = Vcf.new
			@file.each do |line|
				line.chomp!
				if line.start_with? "#CHROM"
					samples = get_samples(line)
				elsif !line.start_with? "#"
					index += 1
					vcf.fill(line,samples)
					out.write rdf.convert(vcf)
					if index % 10000 == 0
						print "\r#{index} records"
					end
					if (@chunks != 0) && (index % @chunks == 0)
						out.close()
						n_chunk += 1
						out = File.open(file_out+"_#{n_chunk}.ttl","w")
						out.write rdf.prefix
					end
				end
				vcf.clear
			end
			puts "\nTotal records converted: #{index}"
			out.close
		end	

	private

		def get_samples(line)
			line.split("\t").slice(9,line.size)	
		end

	end


	
	
end
