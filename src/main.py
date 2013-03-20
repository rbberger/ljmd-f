import input 
import particle_load as Pdata
import output
from fintegration import ljmd as fi
if __name__ == "__main__":
    p = input.Parameters()			# To load the Parameters
    p.load_from_file("../examples/argon_108.inp")  # To load initial pos and vel
    pd = Pdata.ParticleData("../examples/argon_108.rest", 108) 	
    out = output.Output(p)
    
    xyzfile = open("position.dat", "w")
    velfile = open("velocity.dat", "w")

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

    fi.set_parameters(p.natoms, p.timestep, p.numsteps, p.outputfreq, p.mass, p.epsilon, p.sigma, p.rcut, p.box)    

    for i in range(p.natoms):
        fi.set_positions_velocities(i+1, pd._position[i][0], pd._position[i][1], pd._position[i][2], pd._vel[i][0], pd._vel[i][1], pd._vel[i][2]) 

    fi.initmdcell()    
    fi.initforceenergy()

    for j in range(p.natoms):
        xyzfile.write( "%f\t%f\t%f\n" % (fi.get_position(j+1,1),fi.get_position(j+1,2),fi.get_position(j+1,3)))
        velfile.write( "%f\t%f\t%f\n" % (fi.get_velocity(j+1,1),fi.get_velocity(j+1,2),fi.get_velocity(j+1,3)))
    xyzfile.close()
    velfile.close()

 
    print '\nStarting simulation ...'
    for n in range(int(p.numsteps)):	
        fi.onestep()
         #  if n % p.outputfreq == 0 :
	  #	pass
          #  out.output(n,temp,ekin,epot,pos)
            #print n	

    out.close()
    
    #   pd.write_out("output.rest")
    fi.closemd()    
    fi.endsimulation()
    print 'End simulation. Bye Bye'
