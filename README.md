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

Set up to use private modules:

```
mkdir $HOME/privatemodules
cp ${MODULESHOME}/modulefiles/null $HOME/privatemodules
```
The second line is just to show you how to generate an empty module file 
that can you can modify as needed. You can delete it if you like.  Some 
useful module files are provided in the privatemodules folder in this
repository.  To have these modules show up when you do `module avail`
Just add this line to your .bashrc file:

`module use --append $HOME/privatemodules`

### Step 2
Run install_cmake3 to install cmake3 in a 'common' directory 
in your $HOME folder with recent versions of these libraries.
Read the comments in this script for more information.

### Step 3
run install_python3 to install python3 in a 'common' directory 
in your $HOME folder with recent versions of these libraries

### Step 3
run install_ngsolve_parallel to install Netgen/Ngsolve for parallel
processing using OpenMPI

### Step 4
run install_ngsolve_serial to install Netgen/Ngsolve for serial processing.

If you need NGSolve special functions for serial or parallel mode, 
you can install the package using those provided scripts.

After a successful initial install, you can use update_serial and 
update_parallel to keep Netgen/Ngsolve updated.

Also you can re-run the install_python and install_cmake scripts to update
those pre-requisites to any desired version.

You can easily switch between the serial and parallel NGSolve installations
e.g. `$ module load ngsolve/parallel` using the module scripts in
privatemodules.

