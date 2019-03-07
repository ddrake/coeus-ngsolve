"""
    Split trials example.

    Suppose we have a script that loops through a large number of
    combinations of different independent variables including 18
    different values for pump_power for a specific 'doping'.  Sometimes
    we might want to run it locally, other times on the cluster.
    
    The script generates some output files and some intermediate
    'cached' files, which we would like to store in different
    directories.  It takes 18 hours to run the script on one node.  If
    we're in a bit of a hurry, we might prefer to run the script on 18
    different nodes, each taking 1 hour to run.  This example gives one
    way to accomplish this by using a bash script 'split_trials' in
    addition to the slurm batch script and this Python script.

    The way it works is that 'split_trials' bash script passes some
    arguments into the slurm batch script, which passes some of those
    arguments (and some additional ones) into this Python script.
    To deal with these arguments, we use the standard Python argparse 
    library.
"""
import argparse

from fiberamp import Simulator


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--pump_power_idx", type=int,
                        help="0-based index into the list of pump_power values")
    parser.add_argument("--doping",
                        help="doping type for the simulation")
    parser.add_argument("--results_dir",
                        help="directory for storing results")
    parser.add_argument("--cache_dir",
                        help="directory for storing cached solutions")
    args = parser.parse_args()
    results_dir = args.results_dir or '.'
    if args.doping and args.pump_power_idx:
        results_file = 'estimator_trials_{}{}.npz'\
                .format(args.doping, args.pump_power_idx) 
    elif args.doping:
        results_file = 'estimator_trials_{}.npz'.format(args.doping)
    else:
        results_file = 'estimator_trials.npz'
    doping = args.doping or 'Tm'
    pump_powers = [500 + i*250 for i in range(19)]

    if args.pump_power_idx is not None:
        pump_powers = [pump_powers[args.pump_power_idx]]

    sim = Simulator(doping, cache=True)
    if args.cache_dir:
        sim.cache_directory = args.cache_dir
    for p in pump_powers:
        results = sim.run_simulation()

    with open(os.path.join(results_dir, results_file), 'wb') as f:
        np.savez(f, results=results, doping=doping)
