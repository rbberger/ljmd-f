# -*- Makefile -*-
SHELL=/bin/sh
# user configuration

FC=gfortran
FFLAGS=-Wall -fPIC -g -O -std=f95
FTOPY=f2py
FTOPYFLAGS=--debug --fcompiler=gfortran -m fintegration 
AR=ar
ARFLAGS=rcsv
SRC=mdsys.f90 cell.f90 ekin.f90 force.f90 integration.f90 physconst.f90 utils.f90
OBJ=$(SRC:.f90=.o)

# normal targets

default: fintegration.so

clean:
	rm -f fintegration.so libljmd.a $(OBJ) *.mod

# object build rules

fintegration.so: ljmd.f90 libljmd.a
	$(FTOPY) $(FTOPYFLAGS) -c $^

libljmd.a: $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

.f90.o:
	$(FC) -c $(FFLAGS) $<

# internal config

.SUFFIXES:
.SUFFIXES: .f90 .o

.PHONY: clean default

# dependencies
mdsys.o:  mdsys.f90
cell.o: cell.f90 mdsys.o utils.o
ekin.o: ekin.f90 mdsys.o physconst.o
force.o: force.f90 utils.o mdsys.o cell.o 
integration.o: integration.f90 mdsys.o physconst.o
physconst.o: physconst.f90 mdsys.o
utils.o: utils.f90 mdsys.o
