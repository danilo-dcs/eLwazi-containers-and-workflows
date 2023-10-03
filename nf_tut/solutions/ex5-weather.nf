#!/usr/bin/env nextflow
nextflow.enable.dsl=2

inp_channel = Channel.fromFilePairs("../data/*dat", size: -1) {
    it -> "${it.baseName[0..3]}" + "-" + "${it.baseName[9..10]}"}

process pasteData {
    input:
    tuple val(key), path(data)

    output:
    path("${key}.res"), emit: concat_ch

    script:
    "paste * > ${key}.res "
}

process concatData {
    publishDir "output", overwrite:true, mode:'move'
    
    input:
    path(res)

    output:
    path("combined.dat"), emit: output_ch

    script:
    "cat * > combined.dat"
}

workflow {
    pasteData(inp_channel)
    concatData(pasteData.out.concat_ch.toList()).view()
}


