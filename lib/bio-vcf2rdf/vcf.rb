module BioVcf2rdf
	class	Vcf	
		attr_accessor :chromosome,:position,:id,:ref,:alt,:quality,:filter,:effect,:genotype	
		
		def fill(line,samples)
			record = line.split("\t")
			(@chromosome,@position,@id,@ref,@alt,@quality,@filter,@effect) = record.slice(0,8)
			@genotype = parse_genotypes(record.slice(9,record.size),samples)	
			@id = "#{@chromosome}-#{@position}" if @id == "."
			effect = @effect.split(";")[-1].split("EFF=")[1].split(",")
			unless effect.nil?
				@effect = {}
				effect.each do |e| 
					data = e.split("(")
					@effect[data.first] = data[1].split("|")[-3]	
				end
			end
		end

		def clear
			(@chromosome,@position,@id,@ref,@alt,@quality,@filter,@effect,@genotype) = ["","","","","","","","",""] 
		end

	private
		
		def parse_genotypes(genotypes,samples)
			Hash[samples.zip(genotypes)]
		end

	end
end

