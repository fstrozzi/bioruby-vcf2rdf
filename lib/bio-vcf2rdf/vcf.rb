module BioVcf2rdf
	class	Vcf	
		attr_accessor :chromosome,:position,:id,:ref,:alt,:quality,:filter,:effect,:genotype	
		
		def initialize(line,samples,uuid)
			record = line.split("\t")
			(@chromosome,@position,@id,@ref,@alt,@quality,@filter,@effect) = record.slice(0,8)
			@genotype = parse_genotypes(record.slice(9,record.size),samples)	
			@id = "VAR-#{uuid}" if @id == "."
			effect = @effect.split(";")[-1].split("EFF=")[1]
			@effect = effect.split("(").first unless effect.nil?
		end

	private
		
		def parse_genotypes(genotypes,samples)
			Hash[samples.zip(genotypes)]
		end

	end
end

