class Layer:
	var rgn = RandomNumberGenerator.new()
	var perm:Array
	var amPe:Array = []
	var values:Array = []
	var unit:float
	var halfUnit:float
	var angle:float
	var PIUnit:float
	var halfPIU:float
	var complexity:int
	var complexityCicle:int


	func _init(seed_:int, complexity:int):
		rgn.seed = seed_

		complexityCicle = complexity*2+1
		perm = math.create_random_list_rg(rgn,complexityCicle)
		perm.append_array(perm)
		var valuesp = math.create_random_list_rg(rgn,complexity)
		var valuesn = []

		for value in valuesp:
			valuesn.append(-value)
		
		values.append_array(valuesn)
		values.append(0)
		values.append_array(valuesp)



		self.complexity = complexity
		halfUnit = .5           / complexity
		unit     = 1.0          / complexity
		angle    = 360.0        / complexity
		PIUnit   = PI           / complexity
		halfPIU  = math.HALF_PI / complexity



	func inverse(x, base = 1) -> float:
		return clamp((-x) + base,0,base)
	func cosSmooth(x:float) -> float:
		return cos(x * PI + PI) * .5 + .5





	var lastt:int = 9999
	func oneDimensionNoiseTest1(x:float, maxPeriod:int = 5) -> float:




		var X = int(x)
		var u = x - X

		var x0 = perm[X]
		var x1 = perm[X + 1]

		var pointAmplitude

		var vx0 = values[x0]
		var vx1 = values[x1]

		

		vx0 = vx0 * unit
		vx1 = vx1 * unit

		var us = cosSmooth(u)
		var ui = inverse(u)

		if (lastt != X):
			lastt = X

		var value = vx0 * inverse(us) + vx1 * us

		return value