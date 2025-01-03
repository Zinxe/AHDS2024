#!/bin/bash

#SBATCH --job-name=snakemake_pipeline
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=3:00:00
#SBATCH --mem=300m
#SBATCH --account=SSCM033324
#SBATCH --output ./slurm_logs/snakemake_%j.out

# 1. set up environment
cd "${SLURM_SUBMIT_DIR}"
echo "Activating Conda environment..."
source ~/installConda.sh
source ~/initConda.sh

mamba env create -f ahds_sa_environment.yml
mamba activate ahds_sa

# 2. set up logs
mkdir -p slurm_logs

# 3. run Snakemake
echo "Starting Snakemake workflow..."
snakemake --cores 1 --use-conda --latency-wait 60

# 4. fin
echo "Snakemake pipeline finished!"
