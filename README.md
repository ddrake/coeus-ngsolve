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
Run `install_cmake3 3.1.3` to install cmake3 in a 'common' directory 
in your $HOME folder with recent versions of these libraries.
Note: cmake 3.1.3 is not the latest version, but we need to install it first because the current version of cmake won't boostrap from the very old cmake on the coeus or gaia.

Once cmake 3.1.3 has installed, edit your .bashrc like this:
`export PATH=$HOME/local/install/bin`

and source the changes `source ~/.bashrc`

Now if you do `which cmake`, you should see
~/common/install/bin/cmake

and if you do cmake --version, you should see
cmake version 3.1.3

Now you're ready to install the latest CMake by running the install script again, e.g.

`./install_cmake3 3.14.5` (or whatever is your preferred version)

Cmake 3.18.1 gave an error with gcc-9.2.0 that it doesn't support enough C++ 11; 3.17.1 didn't have a problem with gcc, but refused to use openssl 1.0.2.  I ended up installing 3.14.5.

Read the comments in the `install_cmake3` script for more information.
CMake versions for download are listed here: 
[https://cmake.org/download/]

### Step 3
run `install_python3` to install python3 in a 'common' directory 
in your $HOME folder with recent versions of these libraries.
Python versions for download are listed here:
[https://www.python.org/downloads/].  Version 3.8.3 should be good.

### Step 3
run `install_ngsolve_serial` to install the latest version of
Netgen/Ngsolve for serial processing.

### Step 4
run `install_ngsolve_parallel` to install the latest version of
Netgen/Ngsolve for parallel processing using OpenMPI

### Finally
If you need NGSolve special functions for serial or parallel mode, 
you can install the package using those provided scripts.

After a successful initial install, you can use `update_serial` and 
`update_parallel` to keep Netgen/Ngsolve updated.

Also you can re-run the `install_python` and `install_cmake` scripts to update
those pre-requisites to any desired version.

You can easily switch between the serial and parallel NGSolve installations
e.g. `$ module load ngsolve/parallel` using the module scripts in
privatemodules.

### Additional scripts
There are some additional scripts provided here for installing Petsc, 
ngs-petsc, and an NGSolve install for the Xeon Phi nodes.  Some additional
steps may be required for these.  Improved scripts and documentation
should be available soon.

