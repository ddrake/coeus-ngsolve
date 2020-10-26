#!/bin/bash
# Slurm Example for Coeus 
# Note: The pound signs in front of the SBATCH commands are necessary.
# To comment out an SBATCH command use an extra #.
# Note: This assumes you have specified to use the serial installation 
#  of NGSolve by placing 'source use_serial' in your .bashrc or executing it
#  manually.

#SBATCH --job-name myjob
#SBATCH --nodes=1                    # Use one node (unless doing MPI)
#SBATCH --ntasks=1                   # Run a single task (unless doing MPI)      
#SBATCH --cpus-per-task=20           # Number of CPU cores per task
#SBATCH --partition=medium
#SBATCH --output=myjob.log
#SBATCH --mail-user=my-email@pdx.edu
#SBATCH --mail-type=END


pwd; hostname;
echo "Starting at wall clock time:"
date
echo "Running CMT on $SLURM_CPUS_ON_NODE CPU cores"

module load gcc-9.2.0
module load ngsolve/serial
module load intel

python3 $HOME/local/fiberamp/cmt/usage_examples/lase_thulium.py

echo "Ending at wall clock time:"
date


