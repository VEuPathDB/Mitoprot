#!/usr/bin/env nextflow
nextflow.enable.dsl=2


process runMitoprot {
  input:
    path 'subset.fa'

  output:
    path 'summary'
    path 'subset.mitoprot'

  script:
    template 'runMitoprot.bash'
}


workflow mitoprot {
  take:
    seqs

  main:
    results = runMitoprot(seqs)
    results[0] \
      | collectFile( storeDir: params.outputDir )
    results[1] \
      | collectFile( storeDir: params.outputDir, name: params.outputFileName )
}