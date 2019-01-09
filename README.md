# coeus-ngsolve
Instructions / scripts for setting up serial and parallel installations of Netgen/Ngsolve on the PSU Coeus cluster

## Overview
Following this installation procedure, you should end up with three
directories in your home directory something like this:

```
.
├── common
│   ├── install
│   │   ├── bin
│   │   ├── include
│   │   ├── lib
│   │   └── share
│   └── src
│       ├── cmake-3.11.2
│       └── Python-3.6.5
├── NGparallel
│   ├── bin
│   ├── include
│   ├── lib
│   ├── ngsolve
│   └── share
└── NGserial
    ├── bin
    ├── include
    ├── lib
    ├── ngsolve
    └── share
```

### Step 1
Add the three export lines to your .bashrc so that it is similar to
the .bashrc file in this repository.

### Step 2
Run install_cmake3 to install cmake3 in a 'common' directory 
in your $HOME folder with recent versions of these libraries

### Step 3
run install_python3 to install python3 in a 'common' directory 
in your $HOME folder with recent versions of these libraries

### Step 3
run install_ngsolve_parallel to install Netgen/Ngsolve for parallel
processing using OpenMPI

### Step 4
run install_ngsolve_serial to install Netgen/Ngsolve for serial processing

### Step 5
Depending on your workflow, you will probably want to uncomment one of the
two lines at the bottom of .bashrc to use serial or parallel by default.

If you need NGSolve special functions for serial or parallel mode, 
you can install the package using those provided scripts.

After a successful initial install, you can use update_serial and 
update_parallel to keep Netgen/Ngsolve updated.

Also you can re-run the install_python and install_cmake scripts to update
those pre-requisites to any desired version.

For convenience, you may want to copy the scripts use_serial and use_parallel
to your home directory.  Then you can easily switch between the serial and
parallel NGSolve installations using e.g. $ source use_parallel

