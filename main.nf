
params.accession = 'SRR11953975'
params.module = 'CoV'

process 'irma' {

	tag { sample }
	container 'cdcgov/irma:v1.1.5'

    input:
    val(sample)
    val(module)
    path("${sample}_R1.fastq")
    path("${sample}_R2.fastq")

    output:
    path "${sample}_irma/amended_consensus/${sample}_irma.fa"

    """
	//premake irma output dirs to avoid docker root issues
	mkdir "${sample}_irma"
	mkdir "${sample}_irma/amended_consensus"
	mkdir "${sample}_irma/figures"
	mkdir "${sample}_irma/intermediate"
	mkdir "${sample}_irma/logs"
	mkdir "${sample}_irma/matrices"
	mkdir "${sample}_irma/secondary"
	mkdir "${sample}_irma/tables"
	
	
	IRMA ${module} "${sample}_1.fastq" "SRR11953975_2.fastq" "${sample}_irma"
	
    """
}

workflow {

	workflow irmacov { 
		irma(params.accession, params.module)
	}

}