SUBROUTINE parameters
INTEGER :: natoms, timestep, numsteps, outputfreq
REAL :: mass, epsilon, sigma, rcut, box
character(len=1024) :: restartFilename, trajectoryFilename, energiesFilename
END SUBROUTINE parameters

SUBROUTINE Initial_pos_vel
real,  allocatable :: pos(:,:), vel(:,:) 

 ALLOCATE(pos(natoms,3), vel(natoms,3))
END SUBROUTINE Initial_pos_vel

