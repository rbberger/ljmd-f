#===============================================================================
# The main python program that uses fortran functions and module to run the MD.
# This program is developed by Alexander, Andrea, Jorge, and Hagoss (JAHA Group)
# Date:March 21, 2013
# Version : 4.20
#  
#===============================================================================
from sys import argv    

script, input_file, particle_file = argv

import input 
import particle_load as Pdata
import output
from fintegration import ljmd as fi                   # Fortran to python interface

if __name__ == "__main__":

    p = input.Parameters()			                  
    p.load_from_file(input_file)  
    pd = Pdata.ParticleData(particle_file, p.natoms)  # Particle position and velocity data	
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

    # Export parameters from python to fortran
    fi.set_parameters(p.natoms, p.timestep, p.numsteps, p.outputfreq, p.mass, p.epsilon, p.sigma, p.rcut, p.box)    
    # Export initial position and velocity from python to fortran 
    for i in range(p.natoms):
        fi.set_positions_velocities(i+1, pd.pos[i][0], pd.pos[i][1], pd.pos[i][2], pd.vel[i][0], pd.vel[i][1], pd.vel[i][2]) 
    
    # Calls initial conditions from fortran for the MD simulation 
    fi.initmdcell()    
    fi.initforceenergy()

    # Sets the position vector into list format
    pos = []
    for j in range(p.natoms):
        pos.append( (fi.get_position(j+1,1), fi.get_position(j+1,2), fi.get_position(j+1,3)) )
        
    print '\nStarting simulation ...'
    for n in range(int(p.numsteps)):	
        fi.onestep()                                    # MD calculation for each step
        temp = fi.get_temp()                            # Get temperature from fortran
        ekin = fi.get_ekin()                            # Get kinetic energy from fortran   
        epot = fi.get_epot()                            # Get potential energy from fortran
        if n % p.outputfreq == 0 :
            out.output(n,temp,ekin,epot,pos)            # Write the output file
    out.close()
    
    fi.closemd()    
    fi.endsimulation()
    print 'End simulation. Bye Bye'
