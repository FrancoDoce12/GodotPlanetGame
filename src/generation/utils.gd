
func test():
	generateQuarterSphereMesh(15,12)
	pass

func generateQuarterSphereMesh(radius,detail):
	# var circularDiameter = PI/2
	var totalDegrees = 90
	var degreeSteps = float(totalDegrees) / detail
	print(degreeSteps,"degreeSteps")
	print(degreeSteps * detail," shuld be ",totalDegrees)

	var points = []
	var ringsDetailsArray = []
	for ringY in range(detail):
		var totalDegreesForY = degreeSteps * ringY
		var y = radius * sin(deg2rad(totalDegreesForY))
		var ringDiameter = radius * cos(deg2rad(totalDegreesForY))
		
		var ringDetail = round(cos(deg2rad(totalDegreesForY)) * detail)
		var degreeStepsNew = float(totalDegrees)/ringDetail
		# print(degreeStepsNew," shuld be float or ",(totalDegrees / ringDetail), " or the float shuld be", (float(totalDegrees)/ringDetail)  )
		ringsDetailsArray.append(ringDetail)
		print(ringDetail," -ringDetail")
		for i in range(ringDetail+1):
			var totalDegreesIn = degreeStepsNew * i
			var x = ringDiameter * cos(deg2rad((totalDegreesIn)))
			var z = ringDiameter * sin(deg2rad((totalDegreesIn)))
			points.append(Vector3(x,y,z))
	


	for i in range(ringsDetailsArray.size()):
		var actualRing = ringsDetailsArray[i]

		

	print(points)


func generateSphereMesh2(radius,detail):

	var cuarterDetail = detail/4
	pass


func generateSphereMesh(size,detail):
	# try that size be a pair number
	# or make it one

	# example
	# size = 30
	# detail = 20
	# var rings = detail
	var radius = size/2

	var poleUp = Vector3(0,radius,0)
	var poleDawn = Vector3(0,-radius,0)
	var stepsByQuarter = detail/4
	var ringStepDistance = (PI/4) / stepsByQuarter

	print(cos(0))
	print(sin(0))


	var firstCuarter = []

	for ring in range(1,stepsByQuarter+1):

		var ringAngle = ring * ringStepDistance
		var ringDiameter = cos((ringAngle))
		var y = sin((ringAngle))
		var stepsByRing = stepsByQuarter * ringDiameter
		print(stepsByQuarter," -stepsByQuarter")
		print(ringDiameter," -ringDiameter")
		print(stepsByRing," -stepsByRing")
		var stepDistance = (PI/4) / stepsByRing
		for step in range(1,stepsByRing+1):
			var stepAngle = step * stepDistance
			var x = cos(stepAngle)
			var z = sin(stepAngle)
			firstCuarter.append(Vector3(x,y,z))

	print(firstCuarter)
	var secondCuarter = []
	var multiplyVector = Vector3(1,-1,1)
	for i in range(firstCuarter.size()):
		var vector = firstCuarter[i]
		var newVector = multiplyVector * vector











func generateLinearMesh(totalX,totalZ):
	# totalX,totalZ are in meters

	var arrayVertexs = []
	var totalVerticesX = totalX + 1
	var totalVerticesZ = totalZ + 1

	for indexZ in range(totalVerticesZ):
		for indexX in range(totalVerticesX):
			arrayVertexs.append(Vector3(indexX,0,indexZ))

	var indexArray = []


	for indexZ in range(totalVerticesZ-1):
		var actualIndex = indexZ * totalVerticesX
		for _indexX in range(totalVerticesX-1):

			var indexUp = actualIndex + totalVerticesX
			var indexLeft = actualIndex + 1
			var indexUpLeft = indexUp + 1
			# hacerlo con mas pasos pequeños
			# hacer funcion que te devuelva el index del vertice actual, osea
			# el que te daria en la posicion de la malla (z=indexZ, x=indexX)

			# making the first tringle
			indexArray.append(actualIndex)
			indexArray.append(indexUpLeft)
			indexArray.append(indexUp)

			# making the second tringle
			indexArray.append(actualIndex)
			indexArray.append(indexLeft)
			indexArray.append(indexUpLeft)

			actualIndex = actualIndex + 1

	var total_surface_array = []
	total_surface_array.resize(Mesh.ARRAY_MAX)

	total_surface_array[ArrayMesh.ARRAY_VERTEX] = PoolVector3Array(arrayVertexs)
	total_surface_array[ArrayMesh.ARRAY_INDEX] = PoolIntArray(indexArray)

	var mesh = ArrayMesh.new()

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, total_surface_array)

	var meshInstance = MeshInstance.new()

	meshInstance.mesh = mesh

	var material = SpatialMaterial.new()
	# Asignar un color al material
	material.albedo_color = Color(255, 0, 0)
	# Asignar el material al MeshInstance
	meshInstance.material_override = material

	return meshInstance



