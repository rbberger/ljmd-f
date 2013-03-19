import input 
import particle_load as Pdata
import output

if __name__ == "__main__":
    p = input.Parameters()			# To load the Parameters
    p.load_from_file("../examples/argon_108.inp")  # To load initial pos and vel
    pd = Pdata.ParticleData("../examples/argon_108.rest", 108) 	
    out = output.Output(p)

    out.write_header()
    print '\nStarting simulation ...'

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
        
    #interface.updcell()
    #interface
    
    temp = 2.3
    ekin = 4.6
    epot = 5.7
    pos = [(1.0, 2.0, 3.0), (4.0, 5.0, 6.0)]
    for n in range(int(p.numsteps)):		
        if n % p.outputfreq == 0 :
            out.output(n,temp,ekin,epot,pos)
            #print n

        #interface.updcell()
        #interface
    out.close()


    print 'End simulation. Bye Bye'
