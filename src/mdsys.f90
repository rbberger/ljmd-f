

! module to hold the complete system information 
MODULE mdsys
  IMPLICIT NONE
  INTEGER, PARAMETER :: dbl = selected_real_kind(14,200)  ! double precision floating point
  INTEGER, PARAMETER :: sgl = selected_real_kind(6,30)    ! single precision floating point
  INTEGER, PARAMETER :: sln = 200                         ! length of I/O input line
  INTEGER :: natoms,nfi,nsteps,nthreads,iflag
  REAL(kind=dbl) dt, mass, epsilon, sigma, box, rcut, Re_Morse, Alpha_Morse, D_Morse
  REAL(kind=dbl) ekin, epot, temp
  REAL(kind=dbl), POINTER, DIMENSION (:,:) :: pos, vel
  REAL(kind=dbl), POINTER, DIMENSION (:,:,:) :: frc
  PUBLIC :: sgl, dbl, sln
END MODULE mdsys
