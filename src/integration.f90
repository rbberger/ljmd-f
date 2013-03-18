 
! velocity verlet
SUBROUTINE velverlet
  USE kinds
  USE mdsys
  USE physconst
  IMPLICIT NONE

  REAL(kind=dbl) :: vfac

  vfac = 0.5_dbl * dt / mvsq2e / mass

  ! first part: propagate velocities by half and positions by full step
  vel(:,:) = vel(:,:) + vfac*frc(:,:,1)
  pos(:,:) = pos(:,:) + dt*vel(:,:)

  ! compute forces and potential energy 
  CALL force

  ! second part: propagate velocities by another half step */
  vel(:,:) = vel(:,:) + vfac*frc(:,:,1) 
END SUBROUTINE velverlet