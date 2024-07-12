process 'irma' {
    publishDir './results/', mode: 'copy'
    tag { sample }
    //container 'cdcgov/irma:v1.1.5'

    input:
    val(sample)
    val(module)
    path(r1)
    path(r2)

    output:
    path "${sample}_irma/"

    """ 
        
    IRMA ${module} $r1 $r2 "${sample}_irma"
        
    """
}

workflow {
    irma(params.accession, params.module, params.read1, params.read2)

}