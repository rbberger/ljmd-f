import input 
import particle_load as Pdata
import output

if __name__ == "__main__":
    p = input.Parameters()			# To load the Parameters
    p.load_from_file("../examples/argon_108.inp")  # To load initial pos and vel
    pd = Pdata.ParticleData("../examples/argon_108.rest", 108) 	
    out = output.Output()
    print 'Starting simulation ...'

    print "\tnatoms", p.natoms
    print "\tmass", p.mass
    print "\tepsilon", p.epsilon
    print "\tsigma", p.sigma 
    print "\trcut", p.rcut
    print "\tbox", p.box
    print "\tnumsteps", p.numsteps
    print "\ttimestep", p.timestep
    print "\toutputfreq", p.outputfreq 
    print "\trestartFilename", p.restartFilename
    print "\ttrajectoryFilename", p.trajectoryFilename
    print "\tenergiesFilename", p.energiesFilename  
    pd.write_out("output.rest")
    for n in range(int(p.numsteps)):		
        if n % p.outputfreq:
             pass

        #interface.updcell()
        #interface
        print n


    print 'End simulation. Bye Bye'
