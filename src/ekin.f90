 

! compute kinetic energy
SUBROUTINE getekin
  USE mdsys, ONLY: natoms, mass, temp, ekin, vel, dbl
  USE physconst
  IMPLICIT NONE

  INTEGER :: i

  ekin = 0.0_dbl
  DO i=1,natoms
     ekin = ekin + 0.5_dbl * mvsq2e * mass * dot_product(vel(i,:),vel(i,:))
  END DO
  temp = 2.0_dbl * ekin/(3.0_dbl*DBLE(natoms-1))/kboltz
  PRINT*, 'temp=',temp
END SUBROUTINE getekin

