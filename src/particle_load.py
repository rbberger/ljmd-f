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

if __name__ == "__main__":
	pd = ParticleData("../examples/argon_108.rest", 108)
	print pd._vel[107]
	#pos = [float(self._position) for i in self._position]
	#vel = [float(self._vel) for i in self._vel]
	print 'Last pos is: ', pd._position[107]
