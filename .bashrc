# .bash

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source /act/etc/profile.d/actbin.sh

# Add these lines to your .bashrc to work with the other scripts 
# in this repository.
export COMMON_INSTALL_DIR=~/common/install

# If you want to use PETSC, install using the provided
# 'install_petsc' script.
# Then uncomment the next three lines and merge the 
# LD_LIBRARY_PATH to include the paths as in the fourth line
# export PETSC_LIB_DIR=$HOME/local/petsc
# export PETSC_DIR=$HOME/petsc-3.11.2
# export PETSC_ARCH=arch-linux2-c-debug
# export LD_LIBRARY_PATH=$COMMON_INSTALL_DIR/lib:$PETSC_LIB_DIR/lib:$PETSC_DIR/$PETSC_ARCH/lib:/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=$COMMON_INSTALL_DIR/lib:/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH

export PATH=$COMMON_INSTALL_DIR/bin:$PATH

# Uncomment this if you want to use ngsolve in serial processing by default
#source use_serial

# Uncomment this if you want to use ngsolve in parallel processing by default
# source use_parallel
