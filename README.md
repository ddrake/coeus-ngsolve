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
edit your .bashrc to look something like the one here

### Step 2
edit and run python3_cmake3 to create a common directory 
in your $HOME folder with recent versions of these libraries

### Step 3
edit and run install_parallel to install Netgen/Ngsolve for parallel
processing using openmpi

### Step 4
edit and run install_serial to install Netgen/Ngsolve for serial processing

### Step 5
Depending on your workflow, you will probably want to uncomment one of the
two lines at the bottom of .bashrc to use serial or parallel by default.
You can also just switch at any time by doing e.g. source use_parallel

 
