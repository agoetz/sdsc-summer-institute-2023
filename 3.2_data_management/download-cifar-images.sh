#!/usr/bin/env bash

#SBATCH --job-name=download-cifar-images
#SBATCH --account=gue998
#SBATCH --reservation=hpcds23cpu
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:05:00
#SBATCH --output=%x.o%j.%N

declare -xr LUSTRE_PROJECTS_DIR="/expanse/lustre/projects/${SLURM_JOB_ACCOUNT}/${USER}"
declare -xr LUSTRE_SCRATCH_DIR="/expanse/lustre/scratch/${USER}/temp_project"

declare -xr LOCAL_SCRATCH_DIR="/scratch/${USER}/job_${SLURM_JOB_ID}"

module reset
module list
printenv

cd "${LOCAL_SCRATCH_DIR}"
git clone https://github.com/YoongiKim/CIFAR-10-images.git
tar -czf CIFAR-10-images.tar.gz CIFAR-10-images/
cp CIFAR-10-images.tar.gz "${HOME}"
cp CIFAR-10-images.tar.gz "${LUSTRE_SCRATCH_DIR}"
