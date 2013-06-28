module BioVcf2rdf
	class	Vcf	
		attr_accessor :chromosome,:position,:id,:ref,:alt,:quality,:filter,:effect,:genotype	
		
		def initialize(record,uuid)
			(@chromosome,@position,@id,@ref,@alt,@quality,@filter,@effect,@genotype) = record
			@id = "VAR-#{uuid}" if @id == "."
			effect = @effect.split(";")[-1].split("EFF=")[1]
			@effect = effect.split("(").first unless effect.nil?
		end
	end
end

