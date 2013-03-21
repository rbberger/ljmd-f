 
MODULE physconst
  USE mdsys
  IMPLICIT NONE
  REAL(kind=dbl), PARAMETER :: kboltz =    0.0019872067_dbl   ! boltzman constant in kcal/mol/K
  REAL(kind=dbl), PARAMETER :: mvsq2e = 2390.05736153349_dbl  ! m*v^2 in kcal/mol
  PUBLIC :: kboltz, mvsq2e
END MODULE physconst
