#!/bin/bash


#SBATCH --job-name='samtools-1.9'
#SBATCH --cpus-per-task=2
#SBATCH --mem=16GB
#SBATCH --output=logs/samtools-1.9-%j-stdout.log
#SBATCH --error=logs/samtool1.9-%j-stderr.log
#SBATCH --time=00:05:00

echo "Submitting SLURM job"
 singularity pull docker://docker.io/danilodcs/containers-workshop:samtools
 singularity exec /home/user05/samtools_container/containers-workshop_samtools.sif samtools --version
