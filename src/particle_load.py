#from sys import argv

#script, filename = argv

class ParticleData(object):
	def __init__(self,filename,natoms):
		self._natoms = natoms
		self._filename = filename
		print "Particle Positions file  %r:" % filename

		f = open(filename)
		self._position = []
		self._vel = []
		
		for i in range(self._natoms):
			str = f.readline()
			temp = [float(x) for x in str.split()]
			self._position.append(tuple(temp))
		for i in range(self._natoms,2*self._natoms):
			str = f.readline()
			temp2 = [float(x) for x in str.split()]
			self._vel.append(tuple(temp2))
		f.close()

	def write_out(self,filename):
		f = open(filename,'w')
		for p in self._position:
			f.write("%f\t%f\t%f\n" % p)
		for v in self._vel:
			f.write("%f\t%f\t%f\n" % v)
		f.close()
		

if __name__ == "__main__":
	pd = ParticleData("../examples/argon_108.rest", 108)
	pd.write_out("output.rest")
