#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.dir = "data/pops/"
dir = params.dir

Channel.fromFilePairs("${dir}/*.{bed,bim,fam}", size:3)
	.map { it -> [ it[0], it[1][0], it[1][1], it[1][2] ]}
	.set { pop_ch }

process run_plink {
   input:
   tuple val(pop), path(bed), path(bim), path(fam)

   output:
   tuple val(pop), path("${pop}.frq"), emit: pop_freq

  """
  plink --bed ${bed} --bim ${bim} --fam ${fam} --freq --out ${pop}
  """
}

process run_count {
   input:
   tuple val(pop), path(freq)


   output:
   tuple val(pop), path("count.txt"), emit: count
  
   """
   wc -l ${freq} > count.txt
   """
}

workflow {
   run_plink(pop_ch)
   run_count(run_plink.out.pop_freq).view()
}
