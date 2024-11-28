#!/bin/bash

#SBATCH --job-name=snakemake_pipeline
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=4:00:00
#SBATCH --mem=300m
#SBATCH --account=SSCM033324
#SBATCH --output ./slurm_logs/snakemake_%j.out

# 1. 设置环境
cd "${SLURM_SUBMIT_DIR}"
echo "Activating Conda environment..."
source ~/initConda.sh
conda activate ahds_sa

# 2. 创建必要目录
mkdir -p slurm_logs

# 3. 运行 Snakemake
echo "Starting Snakemake workflow..."
snakemake --cores 1 --use-conda --latency-wait 60

# 4. 完成
echo "Snakemake pipeline finished!"
