#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.dir = "data/pops/"
dir = params.dir
params.pops = ["YRI","CEU","BEB"]

Channel.from(params.pops)
    .map { pop ->
        [ file("$dir/${pop}.bed"), file("$dir/${pop}.bim"), file("$dir/${pop}.fam")]
    }
    .set { plink_data }
    
plink_data.subscribe { println "$it" }
