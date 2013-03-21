class Output:
    def __init__(self, parameters):
        self.logfile=open(parameters.energiesFilename, "w")
        self.xyzfile=open(parameters.trajectoryFilename, "w")
        self.parameters = parameters

    def write_header(self):
        print "Starting Simulation with", self.parameters.natoms, "atoms for", self.parameters.numsteps, "steps"
        print "NFI\t TMP\t EKIN\t EPOT\t ETOT"

    def output(self, nfi, temp, ekin, epot, positions):
        self.logfile.write("\t%8d\t%20.8f\t%20.8f\t%20.8f\t%20.8f\n" %  (nfi, temp, ekin, epot, ekin+epot))
        print "%d\t%f\t%f\t%f\t%f" % (nfi, temp, ekin, epot, ekin+epot)
        self.xyzfile.write("%d\n" % self.parameters.natoms)
        self.xyzfile.write("%s%d\t%s%f\n" % ("nfi=", nfi, "etot=", ekin+epot))
        for p in positions:
            self.xyzfile.write("(Ar, %f, %f, %f)\n" % p)
        
    def close(self):
        self.logfile.close()
        self.xyzfile.close()

if __name__ == "__main__":
    import input as p
    para =p.Parameters()
    para.load_from_file("../examples/argon_108.inp")
    print para.trajectoryFilename
    out = Output(para)
    out.write_header()
    out.output(1,1.0,2.0,3.0,[(1.0, 2.0, 3.0), (4.0, 5.0, 6.0)])
    out.close()
