# This is the feature_counting workflow step

version 1.0

workflow counting_workflow {

  input{
    String outputFilename
    String? attribute
    Array[File] seqFiles  #path to the files
    File annotationFile 
  }


  scatter (file in seqFiles){
    call count_task {
      input: 
         sequence_in = file,
         annotation_in = annotationFile,
         outputFilename_in = outputFilename,
         attribute_in = attribute 
    }
  }

  output {
     Array[File] outputFile = count_task.counting_output
  }

} 

task count_task {
  input{
    File annotation_in
    File sequence_in
    String attribute_in = "gene_id" 
    String outputFilename_in
  }

  command {
     featureCounts -t exon -g ~{attribute_in} -a ~{annotation_in} -o ~{outputFilename_in} ~{sequence_in} > ~{outputFilename_in}
  }

  runtime {
    docker: "mohammedfarahat/rna-seq:featurecounts"
  }

  output {
    File counting_output = '~{outputFilename_in}'
  }
}


