 
MODULE cell
  USE kinds
  IMPLICIT NONE
  INTEGER :: npair, ncell, ngrid, nidx
  INTEGER, POINTER :: npercell(:), clist(:,:), plist(:)
  REAL(KIND=dbl), PARAMETER :: cellrat = 2.0_dbl
  INTEGER, PARAMETER :: cellfreq = 4
  REAL(KIND=dbl) :: dcell
  PRIVATE
  PUBLIC :: ncell, npair, clist, plist, npercell
  PUBLIC :: mkcell, updcell, rmcell
  
CONTAINS

  SUBROUTINE mkcell
    USE io
    USE mdsys
    USE utils
    REAL(kind=dbl) :: boxby2, boxoffs, x1, y1, z1, x2, y2, z2, rx, ry, rz
    INTEGER :: i, j, k
    
        
    ngrid   = FLOOR(cellrat * box / rcut)
    ncell   = ngrid * ngrid * ngrid
    dcell   = box / ngrid
    boxby2  = 0.5_dbl * box
    boxoffs = boxby2 - 0.5_dbl*dcell
    nidx = 2*natoms / ncell + 2
    nidx = ((nidx/2) + 1) * 2
        
    ! allocate cell list storage 
    ALLOCATE(npercell(ncell), clist(ncell,nidx), plist(2*ncell*ncell))

    ! build cell pair list, assuming newtons 3rd law. */
    npair = 0
    DO i=0, ncell-2
       k  = i/ngrid/ngrid
       x1 = k*dcell - boxoffs
       y1 = ((i-(k*ngrid*ngrid))/ngrid)*dcell - boxoffs
       z1 = MOD(i,ngrid)*dcell - boxoffs
       
       DO j=i+1, ncell-1
          k  = j/ngrid/ngrid
          x2 = k*dcell - boxoffs
          y2 = ((j-(k*ngrid*ngrid))/ngrid)*dcell - boxoffs
          z2 = MOD(j,ngrid)*dcell - boxoffs
          
          rx=pbc(x1-x2, boxby2, box)
          ry=pbc(y1-y2, boxby2, box)
          rz=pbc(z1-z2, boxby2, box)

          ! check for cells on a line that are too far apart
          IF (ABS(rx) > rcut+dcell) CYCLE
          IF (ABS(ry) > rcut+dcell) CYCLE
          if (ABS(rz) > rcut+dcell) CYCLE

          ! check for cell within a plane that are too far apart.
          IF (SQRT(rx*rx+ry*ry) > (rcut+SQRT(2.0_dbl)*dcell)) CYCLE
          IF (SQRT(rx*rx+rz*rz) > (rcut+SQRT(2.0_dbl)*dcell)) CYCLE
          IF (SQRT(ry*ry+rz*rz) > (rcut+SQRT(2.0_dbl)*dcell)) CYCLE

          ! other cells that are too far apart 
          IF (DSQRT(rx*rx + ry*ry + rz*rz) > (DSQRT(3.0_dbl)*dcell+rcut)) CYCLE
                
          ! cells are close enough. add to list.
          npair=npair+1
          plist(2*npair-1) = i+1
          plist(2*npair  ) = j+1
       END DO
    END DO

    WRITE(stdout,'(A,I2,"x",I2,"x",I2,"=",I6,A,I8,"/",I12,A,I4,A)') 'Cell list has ', &
         ngrid, ngrid, ngrid, ncell, ' cells with ', npair, ncell*(ncell-1)/2, &
         ' pairs and ', nidx, ' atoms/celllist'
  END SUBROUTINE mkcell

  ! update cell list contents
  SUBROUTINE updcell
    USE io
    USE mdsys
    USE utils

    INTEGER :: i, j, k, m, n, midx, idx
    REAL(kind=dbl) :: boxby2

    IF (MOD(nfi,cellfreq) > 0) RETURN

    npercell(:) = 0
    midx = 0

    DO i=1, natoms
       
       ! compute atom position in cell grid and its array index
       k=FLOOR((pbc(pos(i,1), boxby2, box)+boxby2)/dcell)
       m=FLOOR((pbc(pos(i,2), boxby2, box)+boxby2)/dcell)
       n=FLOOR((pbc(pos(i,3), boxby2, box)+boxby2)/dcell)
       j = ngrid*ngrid*k+ngrid*m+n+1
       idx = npercell(j) + 1
       clist(j,idx) = i
       npercell(j) = idx
       IF (idx > midx) midx=idx
    END DO
    IF (midx > nidx) THEN
       WRITE(stdout, '(A,I8,"/",I8,A)') 'Overflow in cell list: ', midx, nidx, ' atoms/cell.'
       STOP 'Fatal error'
    END IF
  END SUBROUTINE updcell

  SUBROUTINE rmcell
    ncell = 0
    nidx  = 0
    ngrid = 0
    npair = 0
    DEALLOCATE(npercell, clist, plist)
  END SUBROUTINE rmcell
END MODULE cell