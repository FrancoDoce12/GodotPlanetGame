
func test():
	return generateQuarterSphereMesh(5,60)


func manangeTriangle(previusIndexes:Array,indexArray:Array,reverseStep:bool):
	if (previusIndexes.size() >= 3):
		var lastPoint = previusIndexes[previusIndexes.size()-1]
		var secondLastPoint = previusIndexes[previusIndexes.size()-2]
		var thirdLastPoint = previusIndexes[previusIndexes.size()-3]

		if (reverseStep):
			indexArray.append(lastPoint)
			indexArray.append(thirdLastPoint)
			indexArray.append(secondLastPoint)
		else:
			indexArray.append(lastPoint)
			indexArray.append(secondLastPoint)
			indexArray.append(thirdLastPoint)



func generateQuarterSphereMesh(radius:int,detail:int):


	#--------------------------------------------------------------------------
	#------------ Starts of Vertexs3 array creation for the mesh --------------
	#--------------------------------------------------------------------------



	var totalDegrees = 90
	var degreeSteps = float(totalDegrees) / detail

	# var points = []
	var ringsDetailsArray = []
	var firstRingPoints
	var notMiddlePoints = []
	for ringY in range(detail):
		var ringsPoints = []

		var totalDegreesForY = degreeSteps * ringY
		var y = radius * sin(deg2rad(totalDegreesForY))
		var ringDiameter = radius * cos(deg2rad(totalDegreesForY))
		
		var ringDetail = round(cos(deg2rad(totalDegreesForY)) * detail)
		var degreeStepsNew = float(totalDegrees)/ringDetail
		ringsDetailsArray.append(ringDetail+1)
		for i in range(ringDetail+1):
			var totalDegreesIn = degreeStepsNew * i
			var x = ringDiameter * cos(deg2rad((totalDegreesIn)))
			var z = ringDiameter * sin(deg2rad((totalDegreesIn)))
			ringsPoints.append(Vector3(x,y,z))
		# points.append_array(ringsPoints)

		if (ringY == 0):
			firstRingPoints = ringsPoints
		else:
			notMiddlePoints.append_array(ringsPoints)




	#--------------------------------------------------------------------------
	#------------- Starts of Indexes array creation for the mesh --------------
	#--------------------------------------------------------------------------



	var actualPointIndex = 0
	var indexesArray = []
	for ring in range(ringsDetailsArray.size()):

		var actualRingSize = ringsDetailsArray[ring]
		var nextRingSize = 0
		# if exsist the next ring, add it
		if (!(ring+1 >= ringsDetailsArray.size())):
			nextRingSize = ringsDetailsArray[ring+1] 
		
		var ringsDiference = int(actualRingSize - nextRingSize)
		

		var lastIndexes = []
		var ringIndexesArray = []

		# ----------------------- adding the ftriangles -----------------------

		match ringsDiference:
			0:
				for _currentPoint in range(actualRingSize):

					var pointA = actualPointIndex
					var pointB = pointA + actualRingSize

					lastIndexes.append(pointA)
					manangeTriangle(lastIndexes,ringIndexesArray,false)
					
					lastIndexes.append(pointB)
					manangeTriangle(lastIndexes,ringIndexesArray,true)

					actualPointIndex = actualPointIndex + 1

			1: 
				
				for currentPoint in range(actualRingSize):

					var pointA = actualPointIndex
					var pointB = pointA + actualRingSize

					lastIndexes.append(pointA)
					manangeTriangle(lastIndexes,ringIndexesArray,false)
					
					if ((currentPoint + 1 != actualRingSize)  ):
						lastIndexes.append(pointB)
						manangeTriangle(lastIndexes,ringIndexesArray,true)
					
					actualPointIndex = actualPointIndex + 1
			2:
				# tgis sitem uses grupes and the middel grup is larger by 1+
				var grupNormalSize = int(nextRingSize / 2)
				var grupSizeRest = int(nextRingSize) % 2
				var grupesSizes = [grupNormalSize,grupSizeRest+2,grupNormalSize]
				for grup in range(3):
					var grupSize = grupesSizes[grup]
					for _step in range(grupSize):
						# there are 2 points in each step
						# point A being the point of the current ring
						# and point B being the point of the next ring that is in front of point A
						var pointA = actualPointIndex
						var pointB = actualPointIndex + actualRingSize - grup

						lastIndexes.append(pointA)
						manangeTriangle(lastIndexes,ringIndexesArray,false)
						
						lastIndexes.append(pointB)
						manangeTriangle(lastIndexes,ringIndexesArray,true)
						
						actualPointIndex = actualPointIndex + 1
			_:
				print("touche the pole!")
				# apply the pole method
				pass

		# print(ringIndexesArray," - ringIndexesArray at the end of the ring for")


		indexesArray.append_array(ringIndexesArray)

	#----------------------------------------------------------------
	#-------------- Initialising the conection points  --------------
	#----------------------------------------------------------------


	# the button ring is the first int(ringsDetailsArray[0]) of the points Array
	var buttonRingIndexes = []
	for pointIndex in range(ringsDetailsArray[0]):
		buttonRingIndexes.append(pointIndex)

	# the top ring is the last int(ringsDetailsArray.back()) of the points Array
	var topRingIndexes = []
	for pointIndex in range(ringsDetailsArray.back()):
		topRingIndexes.push_front(firstRingPoints.size() + notMiddlePoints.size() - pointIndex-1)
	
	# the vertical line are the first points of each ring, meaking a perfect line with all points the same z value, z=0 
	# var verticalLineIndexes = []
	# var verticalLineIndexesCount = 0
	# for detailInRing in range(ringsDetailsArray):
	# 	verticalLineIndexes.append(verticalLineIndexesCount)
	# 	verticalLineIndexesCount = verticalLineIndexesCount + ringsDetailsArray[detailInRing]

	var points = firstRingPoints + notMiddlePoints

	
	print(ringsDetailsArray)
	print(points)
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
