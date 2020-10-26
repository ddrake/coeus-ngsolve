# coeus-ngsolve
Instructions / scripts for setting up serial and parallel installations of Netgen/Ngsolve on the PSU Coeus or Gaia cluster

## Overview
Following this installation procedure, you should end up with
directories in your home directory something like this:

```
.
├── coeus-ngsolve
├── common
│   ├── install
│   │   ├── bin
│   │   ├── include
│   │   ├── lib
│   │   └── share
│   └── src
│       ├── cmake-3.15.7
│       └── Python-3.6.12
├── NGparallel
│   ├── bin
│   ├── include
│   ├── lib
│   ├── ngsolve
│   └── share
├── NGserial
│   ├── bin
│   ├── include
│   ├── lib
│   ├── ngsolve
│   └── share
└── local
    ├── pyeigfeast
    ├── fiberamp
    └── my_python_project

```
### Step 0
 * Fill out the [form](https://portlandstate.atlassian.net/servicedesk/customer/portal/2/create/148?src=-899265461) to request access to the clusters.  You should get an email with instructions within a few days.
 * Install the [Cisco VPN client](https://www.pdx.edu/technology/vpn) on your local machine. 
 * Create accounts at Github and Bitbucket (if you don't already have them),
 generate SSH keys for your local machine(s) and copy/paste the contents of the public key file `id_rsa.pub` to your Github account.
  There are good instructions for this [here](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh).
(personallly I'd recommend either no passphrase or a short one that you can remember).
Add the public key to your Bitbucket account as well.
 * Once you have been granted access to the cluster,
Follow the [Getting Started](https://sites.google.com/pdx.edu/research-computing/getting-started/coeus-hpc-cluster) steps.

### Step 1 (after you've logged in to the cluster and logged out)   

On your local machine, copy the contents of `~/.ssh/id_rsa.pub`, your SSH public key, to your clipboard.
 Then on the cluster node, do `nano ~/.ssh/authorized_keys`, and paste this key text at the bottom of the file.
This will allow you to access the cluster via ssh and sftp without having to enter a password each time.

Also, while you're at it, locate the public key file on the cluster: `~/.ssh/id_rsa_pub`
and copy/paste its contents to your GitHub and Bitbucket accounts so you can work with
your repositories from the cluster without having to enter passwords.

### Step 3

Clone this repository to your home directory on the login node.

`cd ~ && git clone git@github.com:ddrake/coeus-ngsolve.git`

### Step 4

Modules are an easy way for ensuring that environment variables such as `$PATH` and `$LD_LIBRARY_PATH` are set correctly
for the process you want to perform.  Usually you will want to have the modules `gcc-9.2.0`, and `intel` (for coeus)
or `intel-18.0`  (for gaia) loaded before you start running a job.
So-called 'private modules' are just a way of extending this functionality for software
(such as the latest NGSolve) that is not installed on the Coeus.
For more info on modules see [here](http://wiki.c2b2.columbia.edu/arcs/index.php/Cluster_Modules)

Add private modules for NGSolve, depending on which cluster you are on:

```
cp -r ~/coeus-ngsolve/privatemodules_coeus ~/ && mv ~/privatemodules_coeus ~/privatemodules
```
or

```
cp -r ~/coeus-ngsolve/privatemodules_gaia ~/ && mv ~/privatemodules_coeus ~/privatemodules
```

It's a good idea to check the last line of each of the module files to ensure that the Python minor version
(e.g. 3.8) associated with NGSolve matches the version you installed in Step 4.
 
The modules `ngsolve/serial`, `ngsolve/parallel` and `ngsolve/phi_serial` should now appear if you type `module avail`.


### Step 5

Edit the file `~/.bashrc` on the cluster node using nano, vim or emacs, pasting in the following lines.  If you
don't know any of these editors, use `nano ~/.bashrc`.
  Uncomment the line for the cluster you are setting up.  The `$CLUSTER` variable is used by several scripts.

```
# export CLUSTER="GAIA"
# export CLUSTER="COEUS"

export COMMON=~/common/install

export PATH=$COMMON/bin:$PATH

export LD_LIBRARY_PATH=$COMMON_INSTALL_DIR/lib:$LD_LIBRARY_PATH

export PYTHONPATH=$HOME/local:$PYTHONPATH

module use --append $HOME/privatemodules
```

Source these changes by `source ~/.bashrc`

### Step 6

Run `install_cmake3 3.1.3` to install cmake3 in a 'common' directory 
in your `$HOME` folder (see the tree above).

Note: Cmake 3.1.3 is not a recent version, but we need to install it first because recent
versions of Cmake won't boostrap from the very old CMake on the Coeus or Gaia.

Now if you do `which cmake`, you should see `~/common/install/bin/cmake`

and if you do cmake --version, you should see
`cmake version 3.1.3`

Now you're ready to install a higher CMake version by running the install script again.

On Coeus or Gaia, you should be able to do:

`./install_cmake3 3.15.7`

You may not be able to get a higher version like 3.16 or 3.17 because the openssl is pretty old on both clusters

CMake versions available for download are listed here: 
[https://cmake.org/download/]

### Step 4

Install Python3

On Coeus, you should be able to do:

`./install_python3 3.8.6`

On Gaia, because of the *really* old openssl, the highest you can go is:

`./install_python3 3.6.12`

Python versions for download are listed here:
[https://www.python.org/downloads/].

### Step 5 

```
pip3 install --upgrade pip
pip3 install ipython numpy scipy sympy matplotlib pytest cxroots
```

### Step 6

Create a local directory where you will put Python projects so (if they have an `__init__.py` file), they will
be in the `PYTHON_PATH` with our `.bashrc` setup

```
mkdir ~/local
cd ~/local
git clone https://bitbucket.org/jayggg/pyeigfeast.git
```

### Step 8

Open `install_ngsolve_serial` in an editor to make sure the cmake command is to your liking.
The Pardiso sparse solver is recommended, but does not appear to be available on Gaia.  On Gaia, UMFPack should be enabled instead.

run `install_ngsolve_serial` to install Netgen/Ngsolve for most purposes.

To test the install, first do
`module load ngsolve/serial`
`module load gcc-9.2.0`
`module load intel` if on coeus or `module load intel-18.0` if on gaia

Then open a python or ipython console and try
`import ngsolve`

### Step 9

Make sure the `module load` commands above are present in your slurm batch script.
Having these in your script means that no matter what your local environment settings are
when your scheduled job is started, the job's environmment will be correct.

Sample 'slurm_coeus' and 'slurm_gaia' scripts are provided here.  Create a working directory
and copy one of these into it and edit as needed.  Then submit your job like this:
`sbatch slurm_gaia`

It's a good idea to read the (short) [Slurm documentation](https://slurm.schedmd.com/documentation.html)

### Updating

To update NGSolve, simply re-run `./install_ngsolve_serial`.  The `NGserial` directory will be deleted and recreated.
If you're using ngs_special_functions, you'll need to re-install it.

You can re-run the `install_python` and `install_cmake` scripts at any time to update
those pre-requisites to any desired version.  It's not necessary to delete previous
versions of these.

### Optional items

If you need NGSolve special functions, such as Bessel functions (fiberamp does), 
you can install that package using the provided scripts.

If you need to use NGSolve's capabilities for splitting the mesh among
 multiple MPI processes, run `./install_ngsolve_parallel`.  This will create a directory `~/NGparallel`.
 You can use  `module load ngsolve/parallel` to set the environment for your scripts. 

Private modules make it easy to switch between the serial and parallel NGSolve
 installations or schedule jobs simultaneously in each context.

### Additional scripts

There are some additional scripts provided here for installing Petsc, 
ngs-petsc, and an NGSolve install for the Xeon Phi nodes.  Some additional
steps may be required for these.  Improved scripts and documentation
are a work in progress as the clusters evolve.

