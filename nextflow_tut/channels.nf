#!/usr/bin/env nextflow 
nextflow.enable.dsl=2

Channel.fromPath("/home/phelelani/*.dat").set { data }

process P1 {
    input:
    path(data)
    
    output:
    path("${data.baseName}.pre"), emit: channelA
    path(data), emit: channelB

    """
    echo dummy > ${data.baseName}.pre
    """
}

process P2 {
    input:
    path(channelA)
    
    output:
    path(channelA), emit: channelC

    """
    if [ ${channelA.baseName} = "a" ]
    then
        echo ${channelA.baseName}
        sleep 4
    else
        echo ${channelA.baseName}
        sleep 1
    fi
    """
}

process P3 {
    echo true
    
    input:
    path(channelB)
    path(channelC)

    script:
    """
    echo "${channelB} - ${channelC}"
    """
}

workflow {
    P1(data)
    P2(P1.out.channelA).view()
    P3(P1.out.channelB, P2.out.channelC)
}

// process P1 {
//     input:
//     path(data)
    
//     output:
//     tuple val("${data.baseName}"), path("${data.baseName}.pre"), emit: channelA
//     tuple val("${data.baseName}"), path(data), emit: channelB
    
//     """
//     echo dummy > ${data.baseName}.pre
//     """
// }

// process P2 {
//     input:
//     tuple val(name), path(channelA)
    
//     output:
//     tuple val("${channelA.baseName}"), path(channelA), emit: channelC

//     """
//     if [ ${channelA.baseName} = "a" ]
//     then
//         echo ${channelA.baseName}
//         sleep 4
//     else
//         echo ${channelA.baseName}
//         sleep 1
//     fi
//     """
// }

// process P3 {
//     echo true
    
//     input:
//     tuple val(name), path(channelB), path(channelC)

//     """
//     echo "${channelB} - ${channelC}"
//     """
// }

// workflow {
//     P1(data)
//     P2(P1.out.channelA)
//     P3(P1.out.channelB.join(P2.out.channelC))
// }
