! 
! simple lennard-jones potential MD code with velocity verlet.
! units: Length=Angstrom, Mass=amu, Energy=kcal
!
! optimized f95 version using cell lists
!
 MODULE LJMD
!PROGRAM LJMD
!  USE io
  USE utils
  USE mdsys
  USE cell
  IMPLICIT NONE
  
!  INTEGER :: nprint, i, j
!  INTEGER, EXTERNAL :: omp_get_num_threads
!  CHARACTER(len=sln) :: restfile, trajfile, ergfile

!  nthreads = 1
  !$OMP parallel shared(nthreads)
  !$OMP master
  !$  nthreads = omp_get_num_threads()
  !$  WRITE(stdout,'(A,I2,A)') 'Running OpenMP version using ',nthreads,' thread(s).'
  !$OMP end master
  !$OMP end parallel

  !READ(stdin,*) natoms
  !READ(stdin,*) mass
  !READ(stdin,*) epsilon
  !READ(stdin,*) sigma
  !READ(stdin,*) rcut
  !READ(stdin,*) box
  !CALL getline(stdin,restfile)
  !CALL getline(stdin,trajfile)
  !CALL getline(stdin,ergfile)
  !READ(stdin,*) nsteps
  !READ(stdin,*) dt
  !READ(stdin,*) nprint

  ! allocate storage for simulation data.
!  ALLOCATE(pos(natoms,3),vel(natoms,3),frc(natoms,3,nthreads))


  ! read restart 
  !OPEN(UNIT=33, FILE=restfile, FORM='FORMATTED', STATUS='OLD')
  !DO i=1,natoms
  !   READ(33,*) (pos(i,j),j=1,3)
  !END DO
  !DO i=1,natoms
  !   READ(33,*) (vel(i,j),j=1,3)
  !END DO
  !CLOSE(33)
  
CONTAINS

SUBROUTINE initMdCell
  ! set up cell list
    CALL mkcell
    CALL updcell
  END SUBROUTINE initMdCell
  
  SUBROUTINE initForceEnergy
  ! initialize forces and energies
  nfi=0
  frc(:,:,:) = 0.0_dbl
  CALL force
  CALL getekin
  END SUBROUTINE initForceEnergy  
  
  
  !CALL ioopen(ergfile, trajfile)

  !WRITE(stdout, *) 'Starting simulation with ', natoms, ' atoms for', nsteps, ' steps'
  !WRITE(stdout, *) '    NFI           TEMP                 EKIN                  EPOT&
  !     &                ETOT'
  !CALL output

  
  ! main MD loop 
!!  DO nfi=1, nsteps
     ! write output, if requested
 !    IF (mod(nfi,nprint) == 0) THEN
!PHYTON         CALL output
  !   END IF

! propagate system and recompute energies
 SUBROUTINE mainLoop
     CALL updcell
     CALL velverlet
     CALL getekin
 END SUBROUTINE mainLoop
 ! END DO

  ! clean up: close files, free memory
 ! WRITE(stdout,'(A)') 'Simulation Done.'
  SUBROUTINE closeMd
    CALL rmcell
!    CALL ioclose
  END SUBROUTINE closeMd
 

!  DEALLOCATE(pos,vel,frc)
!END PROGRAM LJMD

SUBROUTINE set_parameters(natomsG, timesstepG, numstepsG, outputfreqG,massG, epsilonG, sigmaG, rcutG, boxG)

INTEGER, intent(in) :: natomsG, timesstepG, numstepsG, outputfreqG
REAL, intent(in) :: massG, epsilonG, sigmaG, rcutG, boxG


natoms = natomsG
dt = timesstepG
nsteps = numstepsG
nfi = outputfreqG
mass = massG
epsilon = epsilonG
sigma = sigmaG
rcut = rcutG
box = boxG

ALLOCATE(pos(natoms,3),vel(natoms,3),frc(natoms,3,nthreads))

END SUBROUTINE set_parameters

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





END MODULE LJMD
