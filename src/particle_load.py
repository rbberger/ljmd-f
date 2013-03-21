#from sys import argv

#script, filename = argv

class ParticleData(object):
	def __init__(self,filename,natoms):
		self.natoms = natoms
		self.filename = filename
		print "Particle Positions file  %r:" % filename

		f = open(filename)
		self.pos = []
		self.vel = []
		
		for i in range(self.natoms):
			str = f.readline()
			temp = [float(x) for x in str.split()]
			self.pos.append(tuple(temp))
		for i in range(self.natoms,2*self.natoms):
			str = f.readline()
			temp2 = [float(x) for x in str.split()]
			self.vel.append(tuple(temp2))
		f.close()

	def write_out(self,filename):
		f = open(filename,'w')
		for p in self.pos:
			f.write("%f\t%f\t%f\n" % p)
		for v in self.vel:
			f.write("%f\t%f\t%f\n" % v)
		f.close()
		

if __name__ == "__main__":
	pd = ParticleData("../examples/argon_108.rest", 108)
	pd.write_out("output.rest")
