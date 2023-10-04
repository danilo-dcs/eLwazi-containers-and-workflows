#!/usr/bin/env nextflow
nextflow.enable.dsl=2

input_ch = Channel.fromPath("data/11.bim")

process getIDs {
    input:
    path(input_ch)

    output:
    path("ids"), emit: id_ch
    path("11.bim"), emit: orig_ch
  
    """
    cut -f 2 ${input_ch} | sort > ids
    """
}

process getDups {
    input:
    path(id_ch)
  
    output:
    path("dups"), emit: dups_ch
  
    """
    uniq -d ${id_ch} > dups
    touch ignore
    """
}

process removeDups {
    publishDir("cleanOutput"), mode: 'copy' 

    input:
    path(dups_ch)
    path(orig_ch)
    
    output:
    path("clean.bim"), emit: output
    
    """
    grep -v -f ${dups_ch} ${orig_ch} > clean.bim
    """
}

workflow {
    getIDs(input_ch)
    getDups(getIDs.out.id_ch)
    removeDups(getDups.out.dups_ch, getIDs.out.orig_ch).subscribe { print "Done!" }
}
