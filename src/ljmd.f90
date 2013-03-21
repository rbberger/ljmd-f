! 
! simple lennard-jones potential MD code with velocity verlet.
! units: Length=Angstrom, Mass=amu, Energy=kcal
!
! optimized f95 version using cell lists
!
 MODULE LJMD
  USE utils
  USE mdsys
  USE cell
  USE physconst 
IMPLICIT NONE 
  

CONTAINS

! set up cell list
SUBROUTINE initMdCell
    CALL mkcell
    CALL updcell
END SUBROUTINE initMdCell

! initialize forces and energies
SUBROUTINE initForceEnergy
  nfi=0
  frc(:,:,:) = 0.0_dbl
  CALL force
END SUBROUTINE initForceEnergy  
  
  
! propagate system and recompute energies
SUBROUTINE onestep
     CALL updcell
     CALL velverlet
     CALL getekin
END SUBROUTINE onestep


! clean up: close files, free memory
SUBROUTINE closeMd
    CALL rmcell
END SUBROUTINE closeMd


!set initial parameters for LJ potential
SUBROUTINE set_parameters(natomsG, timesstepG, numstepsG, outputfreqG,massG, epsilonG, sigmaG, rcutG, boxG, iflagG)
INTEGER, intent(in) :: natomsG, timesstepG, numstepsG, outputfreqG, iflagG
REAL, intent(in) :: massG, epsilonG, sigmaG, rcutG, boxG

!defining global variables
natoms = natomsG
dt = timesstepG
nsteps = numstepsG
nfi = outputfreqG
mass = massG
epsilon = epsilonG
sigma = sigmaG
rcut = rcutG
box = boxG
nthreads = 1
iflag = iflagG
ALLOCATE(pos(natoms,3),vel(natoms,3),frc(natoms,3,nthreads))
END SUBROUTINE set_parameters


!set initial parameters for MORSE  potential

SUBROUTINE set_parameters_Morse(natomsG, timesstepG, numstepsG, outputfreqG,massG, &
D_MorseG, Alpha_MorseG, Re_MorseG, rcutG, boxG, iflagG)
INTEGER, intent(in) :: natomsG, timesstepG, numstepsG, outputfreqG, iflagG
REAL, intent(in) :: massG, D_MorseG, Alpha_MorseG,Re_MorseG, rcutG, boxG

!defining global variables
natoms = natomsG
dt = timesstepG
nsteps = numstepsG
nfi = outputfreqG
mass = massG
rcut = rcutG
box = boxG
nthreads = 1
D_Morse = D_MorseG
Alpha_Morse = Alpha_MorseG
Re_Morse = Re_MorseG
iflag = iflagG
ALLOCATE(pos(natoms,3),vel(natoms,3),frc(natoms,3,nthreads))
END SUBROUTINE set_parameters_Morse


!clear memory
SUBROUTINE ENDSIMULATION
PRINT*, 'Deallocating storage in Fortran...'
DEALLOCATE(pos,vel,frc)
END SUBROUTINE ENDSIMULATION


!set initial positions and velocities of each atoms
SUBROUTINE set_positions_velocities(id,x,y,z,vx,vy,vz) 
INTEGER, INTENT(IN) :: id
REAL, INTENT(in) :: x, y, z, vx, vy, vz

pos(id,1) = x
pos(id,2) = y
pos(id,3) = z
vel(id,1) = vx
vel(id,2) = vy
vel(id,3) = vz

END SUBROUTINE set_positions_velocities


!get temperture
FUNCTION get_temp()
REAL(8) :: get_temp
CALL getekin
get_temp = temp
END FUNCTION

!get kinetic energy
FUNCTION get_ekin()
REAL(8) :: get_ekin
CALL getekin
get_ekin = ekin
END FUNCTION
!get potential energy
FUNCTION get_epot()
REAL(8) :: get_epot
CALL force
get_epot = epot
END FUNCTION


!get positions
FUNCTION get_position(id, coord)
INTEGER, INTENT(IN) :: id
INTEGER, INTENT(IN) :: coord
REAL(8) :: get_position 
 get_position = pos(id, coord)
END FUNCTION


!get velocities
FUNCTION get_velocity(id,coord)
INTEGER, INTENT(IN) :: id
INTEGER, INTENT(IN) :: coord
REAL (8) :: get_velocity
 get_velocity = vel(id,coord)
END FUNCTION

END MODULE LJMD
