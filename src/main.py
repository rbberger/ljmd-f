import input 
import particle_load as Pdata
import output
from fintegration import ljmd as fi
if __name__ == "__main__":
    p = input.Parameters()			# To load the Parameters
    p.load_from_file("../examples/argon_108.inp")  # To load initial pos and vel
    pd = Pdata.ParticleData("../examples/argon_108.rest", 108) 	
    out = output.Output(p)

    out.write_header()
    print "\nParameters:"
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
    
    #temp = 2.3
    #ekin = 4.6
    #epot = 5.7
    #pos = [(1.0, 2.0, 3.0), (4.0, 5.0, 6.0)]

    fi.set_parameters(p.natoms, p.timestep, p.numsteps, p.outputfreq, p.mass, p.epsilon, p.sigma, p.rcut, p.box)    
    #algo = fi.set_parameters(2, 2, 3, 4,1.0, 4.5, 3.0, 1.0, 3.0)   
    

    for i in range(p.natoms):
        fi.set_positions_velocities(i+1, pd._position[i][0], pd._position[i][1], pd._position[i][2], pd._vel[i][0], pd._vel[i][1], pd._vel[i][2]) 

    print '\nStarting simulation ...'
    for n in range(int(p.numsteps)):		
        if n % p.outputfreq == 0 :
            pass
            #out.output(n,temp,ekin,epot,pos)
            #print n

        #interface.updcell()
        #interface
    #out.close()
    
    #fi.physconst.lala()
    fi.tesdt()
    
    print 'End simulation. Bye Bye'
