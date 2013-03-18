def convert_to_float(x):
    try:
        return float(x)
    except ValueError:
        return None

class Parameters:
    def __init__(self):
        self.natoms = 108
        self.mass = 39.948
        self.epsilon = 0.2379
        self.sigma = 3.405
        self.rcut = 8.5
        self.box = 17.1580
        self.numsteps = 10000
        self.timestep = 5
        self.outputfreq = 100
        self.restartFilename = ""
        self.trajectoryFilename = ""
        self.energiesFilename = ""
        
    def load_from_file(self, filename):
        p = Parameters()
        
        # read data from file
        f = open(filename, "r")
        
        def get_float_parameter(line):
            temp = [convert_to_float(x) for x in line.split()]
            return temp
        
        def get_string_parameter(line):
            return line.split()

        # number of atoms
        line = f.readline()
        self.natoms = get_float_parameter(line)[0]
        # mass in AMU
        line = f.readline()
        self.mass = get_float_parameter(line)[0]
        # epsilon in kcal/mol
        line = f.readline()
        self.epsilon = get_float_parameter(line)[0]
        # sigma in angstrom       
        line = f.readline()
        self.sigma = get_float_parameter(line)[0]
        # rcut in angstrom
        line = f.readline()
        self.rcut = get_float_parameter(line)[0]
        # box length (in angstrom)
        line = f.readline()
        self.box = get_float_parameter(line)[0]
        # restart
        line = f.readline()
        self.restartFilename =  get_string_parameter(line)[0]
        # trajectory
        line = f.readline()
        self.trajectoryFilename = get_string_parameter(line)[0]
        # energies
        line = f.readline()
        self.energiesFilename = get_string_parameter(line)[0]
        # nr MD steps
        line = f.readline()
        self.numsteps = get_float_parameter(line)[0]   
        # MD time step (in fs)
        line = f.readline()
        self.timestep = get_float_parameter(line)[0]
        # output print frequency
        line = f.readline()
        self.outputfreq = get_float_parameter(line)[0]

        f.close()
        return p

if __name__ == "__main__":
	p = Parameters()
	p.load_from_file("../examples/argon_108.inp")
	print "natoms", p.natoms
        print "mass", p.mass
        print "epsilon", p.epsilon
        print "sigma", p.sigma 
        print "rcut", p.rcut
        print "box", p.box
        print "numsteps", p.numsteps
        print "timestep", p.timestep
        print "outputfreq", p.outputfreq 
        print "restartFilename", p.restartFilename
        print "trajectoryFilename", p.trajectoryFilename
        print "energiesFilename", p.energiesFilename 


