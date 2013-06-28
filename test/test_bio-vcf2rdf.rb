
require "helper"

class TestBioVcf2rdf < Test::Unit::TestCase
  context BioVcf2rdf::Rdfizer do
		should "emit standard prefixes" do
			r = BioVcf2rdf::Rdfizer.new("cow")
			assert_equal("@prefix ngs: <http://genome.db/ngs/> .\n@prefix var: <http://genome.db/var/> .\n@prefix sample: <http://genome.db/sample/> .\n@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .\n@prefix faldo: <http://biohackathon.org/resource/faldo#> .\n",r.prefix)
  	end
	end

	context BioVcf2rdf::Vcf do
		should "take a splitted line from VCF file and create a Vcf object" do
			line = "1\t316\t.\tC\tCA\t234.75\t.\tAC=2;AF=1.00;AN=2;DP=11;FS=0.000;MLEAC=2;MLEAF=1.00;MQ=51.35;MQ0=0;QD=21.34;RPA=6,7;RU=A;STR;EFF=intergenic_region(MODIFIER||||||||||1)\tGT:AD:DP:GQ:PL\t1/1:0,8:9:24:272,24,0\t1/1:0,8:9:24:272,24,0\t1/1:0,8:9:24:272,24,0"
			samples = ["Sample_A","Sample_B","Sample_C"]
			vcf = BioVcf2rdf::Vcf.new(line,samples,1)
			assert_equal("1",vcf.chromosome)
			assert_equal("316",vcf.position)
			assert_equal("VAR-1",vcf.id)
			assert_equal("C",vcf.ref)
			assert_equal("CA",vcf.alt)
			assert_equal("234.75",vcf.quality)
			assert_equal(vcf.genotype,{"Sample_A" => "1/1:0,8:9:24:272,24,0","Sample_B" => "1/1:0,8:9:24:272,24,0","Sample_C" => "1/1:0,8:9:24:272,24,0"})
		end
	end

end

