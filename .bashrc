# .bash

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
        
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
        
# User specific aliases and functions
source /act/etc/profile.d/actbin.sh
export COMMON_INSTALL_DIR=~/common/install
        
export GCC_DIR=/vol/apps/gcc/gcc-7.2.0
export LD_LIBRARY_PATH=$GCC_DIR/lib/:$GCC_DIR/lib64:$GCC_DIR/lib/gcc/x86_64-redhat-linux/7.2.0:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$COMMON_INSTALL_DIR/lib:/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH
        
export PATH=$COMMON_INSTALL_DIR/bin:$GCC_DIR/bin/:$PATH
        
module load gcc-7.2.0

# Uncomment this if you want to use ngsolve in serial processing by default
# source use_serial

# Uncomment this if you want to use ngsolve in parallel processing by default
# source use_parallel
