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

export LD_LIBRARY_PATH=$COMMON_INSTALL_DIR/lib:/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH
        
export PATH=$COMMON_INSTALL_DIR/bin:$PATH
        
# Uncomment this if you want to use ngsolve in serial processing by default
#source use_serial

# Uncomment this if you want to use ngsolve in parallel processing by default
# source use_parallel
