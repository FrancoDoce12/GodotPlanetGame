
func test():
	return generateQuarterSphereMesh(10,10)
	

func generateQuarterSphereMesh(radius,detail):

	var totalDegrees = 90
	var degreeSteps = float(totalDegrees) / detail
	# print(degreeSteps," -degreeSteps")
	# print(degreeSteps * detail," shuld be ",totalDegrees)

	var points = []
	var ringsDetailsArray = []
	for ringY in range(detail):
		var totalDegreesForY = degreeSteps * ringY
		var y = radius * sin(deg2rad(totalDegreesForY))
		var ringDiameter = radius * cos(deg2rad(totalDegreesForY))
		
		var ringDetail = round(cos(deg2rad(totalDegreesForY)) * detail)
		var degreeStepsNew = float(totalDegrees)/ringDetail
		# print(degreeStepsNew," shuld be float or ",(totalDegrees / ringDetail), " or the float shuld be", (float(totalDegrees)/ringDetail)  )
		ringsDetailsArray.append(ringDetail+1)
		# print(ringDetail," -ringDetail")
		for i in range(ringDetail+1):
			var totalDegreesIn = degreeStepsNew * i
			var x = ringDiameter * cos(deg2rad((totalDegreesIn)))
			var z = ringDiameter * sin(deg2rad((totalDegreesIn)))
			points.append(Vector3(x,y,z))
	
	var actualPointIndex = 0
	var indexesArray = []
	for ring in range(ringsDetailsArray.size()):
		print(ring," -ring")

		var actualRingSize = ringsDetailsArray[ring]
		print(actualRingSize," -actualRingSize")
		var nextRingSize = 0
		# if exsist the next ring, add it
		if (!(ring+1 >= ringsDetailsArray.size())):
			nextRingSize = ringsDetailsArray[ring+1] 
		
		print(actualRingSize," -actualRingSize")
		print(nextRingSize," -nextRingSize")
		var ringsDiference = actualRingSize - nextRingSize
		print(ringsDiference, " -ringsDiference")
		# TODO make a consistent var actualPointIndex across all rings
		
		var lastIndexes = []
		var ringIndexesArray = []
		
		if (ringsDiference == 2):
			# apply the grups method
			var grupSize = (int(nextRingSize / 2)) 
			for grup in range(3):
				for _step in range(grupSize):
					print("step!")
					print(actualPointIndex," -actualPointIndex into one step")
					# there are 2 points in each step
					# point A being the point of the bigger ring
					# and point B being the point of the next ring that is in front of point A
					var pointA = actualPointIndex
					print(pointA)
					var pointB = actualPointIndex + actualRingSize - grup

					lastIndexes.append(pointA)
					if (lastIndexes.size() >= 3):
						var lastPoint = lastIndexes[lastIndexes.size()-1]
						var secondLastPoint = lastIndexes[lastIndexes.size()-2]
						var thirdLastPoint = lastIndexes[lastIndexes.size()-3]

						ringIndexesArray.append(lastPoint)
						ringIndexesArray.append(secondLastPoint)
						ringIndexesArray.append(thirdLastPoint)
					
					lastIndexes.append(pointB)

					if (lastIndexes.size() >= 3):
						var lastPoint = lastIndexes[lastIndexes.size()-1]
						var secondLastPoint = lastIndexes[lastIndexes.size()-2]
						var thirdLastPoint = lastIndexes[lastIndexes.size()-3]
						
						ringIndexesArray.append(lastPoint)
						ringIndexesArray.append(thirdLastPoint)
						ringIndexesArray.append(secondLastPoint)
					
					actualPointIndex = actualPointIndex + 1
		elif (!nextRingSize):
			print("touche the pole!")
			print(actualPointIndex," -actualPointIndex it is ojay?")
			# apply the pole method
			pass
		else:
			# apply the ping pong method
			for _point in range(actualRingSize):
				var pointA = actualPointIndex
				print(pointA)
				var pointB = pointA + actualRingSize
				lastIndexes.append(pointA)
				if (lastIndexes.size() >= 3):
					var lastPoint = lastIndexes[lastIndexes.size()-1]
					var secondLastPoint = lastIndexes[lastIndexes.size()-2]
					var thirdLastPoint = lastIndexes[lastIndexes.size()-3]

					ringIndexesArray.append(lastPoint)
					ringIndexesArray.append(secondLastPoint)
					ringIndexesArray.append(thirdLastPoint)


				lastIndexes.append(pointB)
				if (lastIndexes.size() >= 3):
					var lastPoint = lastIndexes[lastIndexes.size()-1]
					var secondLastPoint = lastIndexes[lastIndexes.size()-2]
					var thirdLastPoint = lastIndexes[lastIndexes.size()-3]
					
					ringIndexesArray.append(lastPoint)
					ringIndexesArray.append(thirdLastPoint)
					ringIndexesArray.append(secondLastPoint)

				actualPointIndex = actualPointIndex + 1
		print(actualPointIndex," - actualPointIndex at the end of the ring for")

		indexesArray.append_array(ringIndexesArray)
	print(indexesArray)
	print(indexesArray)
	return createMeshInstance(points,indexesArray)


	# print(points)







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



func createMeshInstance(vertexArray,indexesArray):
	
	var total_surface_array = []
	total_surface_array.resize(Mesh.ARRAY_MAX)

	total_surface_array[ArrayMesh.ARRAY_VERTEX] = PoolVector3Array(vertexArray)
	total_surface_array[ArrayMesh.ARRAY_INDEX] = PoolIntArray(indexesArray)

	var mesh = ArrayMesh.new()

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, total_surface_array)

	var meshInstance = MeshInstance.new()

	meshInstance.mesh = mesh

	return meshInstance
