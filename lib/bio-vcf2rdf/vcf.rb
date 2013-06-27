module BioVcf2rdf
	class	Vcf	
		attr_accessor :chromosome,:position,:id,:ref,:alt,:quality,:filter,:genotype	
		
		def initialize(record)
			(@chromosome,@position,@id,@ref,@alt,@quality,@filter,@genotype) = record
			@id = "VAR"+UUID.new.generate.split("-").first if @id == "."
		end
	end
end

