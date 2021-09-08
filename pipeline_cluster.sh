#!/bin/bash
#SBATCH --job-name=pipeline
#SBATCH --output=pipeline.log
#SBATCH --time=23:59:59
#SBATCH --mem=11GB
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --partition=gpu
#SBATCH --exclude=node-12,dgx-2,dgx-3,dgx-4,dgx-5

module purge
module load OpenCV/3.4.1-foss-2018a-Python-3.6.4
module load cuDNN/7.6.4.38-gcccuda-2019b
module load CUDA/10.2.89-GCC-8.3.0
module load Anaconda3/5.0.1
source /opt/apps/software/Anaconda3/5.0.1/etc/profile.d/conda.sh
export TORCH_CUDA_ARCH_LIST="6.1;7.0"
source env/bin/activate

nvidia-smi
nvcc --version

singularity run --fakeroot --writable pipeline.simg

echo finished

