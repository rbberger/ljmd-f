
MODULE init
real, allocatable, dimension(:,:,:) :: pos,vel
END MODULE init

MODULE iointerface
  interface data
    SUBROUTINE initPosition(types,xyz)
      use init
	implicit none
	real types
	real,dimension(:) :: xyz
    END SUBROUTINE initPosition  
  
  end interface data
  
  SUBROUTINE initParameters
  
  
  END SUBROUTINE init Parameters
END MODULE iointerface

contains

subroutine test
  use init
  use iointerface
  implicit none
  integer :: i,id,nAtoms
  write(*,*) 'input N of types'
  READ(*,*) id
  do i=1,id
    write(*,*) 'input N atom of type'
    read(*,*) nAtoms
    allocate(pos(i,nAtoms,3))
    allocate(vel(i,nAtoms,3))
  
  end do
  
  
  
end subroutine test
!SUBROUTINE




  
  
  
  




!set_mass(int id, double mass)
!set_epsilon(double)
!set_sigma
!set_rcut
!set_boxlength*
!set_particle_data(pos*, vel*)
!get_particle_data(pos*, vel*)
!calculate_step()
!get_ekin()


! # natoms
!39.948            # mass in AMU
!0.2379            # epsilon in kcal/mol
!3.405             # sigma in angstrom
!8.5               # rcut in angstrom
!17.1580           # box length (in angstrom)
!argon_108.rest    # restart
!argon_108.xyz     # trajectory
!argon_108.dat     # energies
!10000             # nr MD steps
!5.0               # MD time step (in fs)
!100               # output print frequency
!lennard-jones     # lennard-jones | morse
!20.0              # temp
