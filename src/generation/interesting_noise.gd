# equivalent to octaves of the perling noise
# the arguments :
# (totalLayers:int, layerPosition:int, generator:RandomNumberGenerator, autoRegulate:bool = true, SCALE:int = 1, STRENGTH:float = 1)
class DetailLayer:

	# SCALE is how often a detail point will be for each unit time 
	# for example in SCALE 4 will be 1 unit of detail each 4 units of time
	var SCALE:int

	# STRENGTH is how much it will influence in all the dimension  
	var STRENGTH:float 

	# it is the father's generator of the themension that will be used in this detail layer
	var generator:RandomNumberGenerator


	# the distance in units of time
	var nextValueDistance:int = SCALE
	var lastValueDistance:int = 0
	var lastValue:float 
	var nextValue:float

	# --------------- sin curve vars ---------------

	# its created in the initialization (asuming that SCALE never gona change)
	# (1 / SCALE)
	var a:float 

	# its changed evry time the dimension is moved one unit of time (using the function getNextValue())
	# f = (a * lastValueDistance)
	var f:float

	# is the strenght aplayed to the lineal interpolaition inside the sinWaveCurve formula inside the (getSinWaveCurveValue())
	# the sinWaveCurve formula is: 

	# (lastValue + (f * nextValue))
	var linearInterpolation:float


	# --------------- sin wave vars ---------------



	func _init(totalLayers:int, layerPosition:int, generator:RandomNumberGenerator, autoRegulate:bool = true, SCALE:int = 1, STRENGTH:float = 1):
		if autoRegulate:
			self.STRENGTH = 1.0 / layerPosition
			self.SCALE = totalLayers - layerPosition + 1
		else:
			self.STRENGTH = STRENGTH
			self.SCALE = SCALE
		self.lastValue = generator.randf()
		self.nextValue = generator.randf()
		self.generator = generator
		self.a = 1.0 / SCALE





	# it tells you if the next "n" moves in the units times, will change the value of the detailLayer
	func changesInNextMoves(movesTimes:int)-> bool:
		return (lastValueDistance + movesTimes) >= SCALE

	func getSinWaveCurveValue():
		var value:float
		var linealInterpolation:float
		var sinWaveInterpolation:float
		var differenceNextValue:float

		differenceNextValue = nextValue - lastValue

		linealInterpolation = lastValue + ( f * differenceNextValue )
		sinWaveInterpolation = sin( f * (2 * PI) ) * differenceNextValue

		value = linealInterpolation + sinWaveInterpolation
		
		return value
	


	func changeToNextValue():
		lastValueDistance = 0
		lastValue = nextValue
		nextValue = generator.randf()
		
		# update the sin wave curve vars
		f = 0



	func getNextValue()-> float:
		lastValueDistance += 1
		
		if lastValueDistance >= SCALE:
			changeToNextValue()
		else:
			f = (a * lastValueDistance)
		return (getSinWaveCurveValue() * STRENGTH)

	# changes temporaly the scale value just for test porposes
	func dtest(temporalScale:int, iterations:int):
		# var originalSCALEvalue = SCALE
		# SCALE = temporalScale

		# var valuesArray:Array = []
		# for i in range(iterations):
		# 	var value = getNextValue()
		# 	valuesArray.append(Vector2(value,i))
		
		# SCALE = originalSCALEvalue

		return String(1234)


func detailTest():

	var x = Dimension.new()

	var layers = []

	layers.append(DetailLayer.new(7,7,x.generator,false,3,0.01))
	layers.append(DetailLayer.new(7,6,x.generator,false,50,0.08))
	layers.append(DetailLayer.new(7,5,x.generator,false,200,0.1))
	layers.append(DetailLayer.new(7,4,x.generator,false,500,0.15))
	layers.append(DetailLayer.new(7,3,x.generator,false,1200,0.2))
	layers.append(DetailLayer.new(7,2,x.generator,false,5000,0.3))
	layers.append(DetailLayer.new(7,1,x.generator,false,10000,0.7))

	x.detailLayers = layers


	x.generate(1000)



class Dimension:

	
	# just the main random numbers generator for all the dimension and their detailLayer`s childs (var detailLayers:Array)
	# it can be the father`s generaor or its own generator 
	# the default behaivor is beeng its having its own generator created by his seed (if seed = -1 means random seed)  
	var generator:RandomNumberGenerator

	# their details layers and his propieties are what define the overall beaheavor, propieties and personality of the dimension
	# the most importan propieties of each detail layer are the SCALE and the STRENGHT, those are what define the "beaheavor, propieties and personality"
	var detailLayers:Array = []

	var timesValue:Dictionary = {}

	var dimensionTime:int = 0
	

	func _init(generateDetailLayers:bool = true ,detailLayers:Array = [], seedi:int =-1):
		self.generator = RandomNumberGenerator.new()
		if seedi <= -1:
			self.generator.seed = randi()
		else:
			self.generator.seed = seedi
		
		if generateDetailLayers:
			self.detailLayers = generateDetailLayers(5)
		else:
			self.detailLayers = detailLayers
	
	
	func generateDetailLayers(totalLayers:int = 10) -> Array:
		var layers = []
		for i in range(1,totalLayers+1):
			layers.append(DetailLayer.new(totalLayers,i,generator))
		return layers

	# gets the next value in the next unit time
	func getNextValues():
		var valuesSum = 0

		for layer in detailLayers:
			valuesSum += layer.getNextValue()
		
		timesValue[str(dimensionTime)] = valuesSum

		dimensionTime += 1
		return valuesSum
	
	func generate(times:int):
		for _i in range(times):
			getNextValues()
		getVectors()

	func getVectors():
		var values = []
		for i in timesValue.keys():
			values.append(Vector2(int(i),timesValue[i]))
		print(values)
		return values

	func getTimeValue(time:int):
		if time >= dimensionTime:
			generate(time - dimensionTime + 1)
		return timesValue[str(time)]


	# comenzar con las funciones para sacar un punto dentro de una dimension ( una unidad de tiempo )


class InterestingNoise:
	# the default behavor of this generator its that is just used to create the "random" seeds for the dimension's generators
	var mainGenerator: RandomNumberGenerator
	var dimensions:Array = []
	# shuld be always >= 1
	var order:int = 1 


	func _init(seedi:int, dimensions:int):
		self.mainGenerator = RandomNumberGenerator.new()
		self.mainGenerator.seed = seedi
		for _i in range(dimensions):
			var randSeed = self.mainGenerator.randi()
			var dimension = Dimension.new(randSeed)
			self.dimensions.append(dimension)

	
	func getValues(dimensionsTime: Array ):
		var dimensionsValues = 0
		for i in range(dimensionsTime.size()):
			var dimensionTime:int = dimensionsTime[i]
			var dimension:Dimension = dimensions[i]

			dimensionsValues += dimension.getTimeValue(dimensionTime)
		
		return (dimensionsValues / dimensionsTime.size())
		







		


func interestinNoiseTest():
	var noise = InterestingNoise.new(2323,2)

	var x = Dimension.new()
	x.generator = noise.mainGenerator
	var layersx = []
	layersx.append(DetailLayer.new(7,7,x.generator,false,3,0.01))
	layersx.append(DetailLayer.new(7,6,x.generator,false,50,0.08))
	layersx.append(DetailLayer.new(7,5,x.generator,false,200,0.1))
	layersx.append(DetailLayer.new(7,4,x.generator,false,500,0.15))
	layersx.append(DetailLayer.new(7,3,x.generator,false,1200,0.2))
	layersx.append(DetailLayer.new(7,2,x.generator,false,5000,0.3))
	layersx.append(DetailLayer.new(7,1,x.generator,false,10000,0.7))
	x.detailLayers = layersx

	var y = Dimension.new()
	y.generator = noise.mainGenerator
	var layersy = []
	layersy.append(DetailLayer.new(7,7,x.generator,false,3,0.01))
	layersy.append(DetailLayer.new(7,6,x.generator,false,50,0.08))
	layersy.append(DetailLayer.new(7,5,x.generator,false,200,0.1))
	layersy.append(DetailLayer.new(7,4,x.generator,false,500,0.15))
	layersy.append(DetailLayer.new(7,3,x.generator,false,1200,0.2))
	layersy.append(DetailLayer.new(7,2,x.generator,false,5000,0.3))
	layersy.append(DetailLayer.new(7,1,x.generator,false,10000,0.7))
	y.detailLayers = layersy




	noise.dimensions.append(x)
	noise.dimensions.append(y)


	var newImg = []

	for i in range(1000):
		var xDimension = []
		for j in range(1000):
			xDimension.append(noise.getValues([i,j]))
		newImg.append(xDimension)
	
	print(newImg)
	return newImg





func interestingNoise():
	var noise = InterestingNoise.new(randi(),7)
	pass

func noiseTest(times:int):
	var noise =  OpenSimplexNoise.new()
	# Configure
	noise.seed = randi()
	noise.octaves = 6
	noise.period = 20.0
	noise.persistence = 0.8

	print(noise.get_noise_2d(5,254),"-1")
	print(noise.get_noise_2d(5,15) ,"-2")
	print(noise.get_noise_2d(5,17) ,"-3")
	print(noise.get_noise_2d(5,16) ,"-4")


	var x = 0_
	var y = 1
	for _i in range(times):
		x += 1
		y += 1
		var value = noise.get_noise_2d(x,y)
		print(value)
