 
MODULE iointerface
  IMPLICIT NONE
  

CONTAINS
  SUBROUTINE inputData !box,eps,
  implicit none
  
  END SUBROUTINE inputData
  
  SUBROUTINE potential(potType,a,b,c)	!Potential parameters
  END SUBROUTINE potential
  
  SUBROUTINE inputMass
  implicit none
  
  END SUBROUTINE inputMass
  
  SUBROUTINE initialPosition
    integer :: i,id,nAtoms
    
    write(*,*) 'input N of types'
    READ(*,*) id
!  do i=1,id
!    allocate(pos(i,nAtoms,3))
!    allocate(vel(i,nAtoms,3))
!    write(*,*) 'Initial Position'
  END SUBROUTINE initialPosition
  
  
END MODULE iointerface