extends Node

var HALF_PI:float = 1.5707963267949

## returns the local position in base of the coordinates without the radius and terrain
func planetCoordinatesToLocal3DPosition(coordinates:Vector2) -> Vector3:

	# var localPosition = Vector3(0,0,0)

	var yCos = cos(deg2rad(coordinates.y))

	# localPosition.y = sin(deg2rad(coordinates.y))
	# localPosition.z = sin(deg2rad(coordinates.x)) * yCos
	# localPosition.x = cos(deg2rad(coordinates.x)) * yCos

	return Vector3(cos(deg2rad(coordinates.x)) * yCos, sin(deg2rad(coordinates.y)), sin(deg2rad(coordinates.x)) * yCos)





func planetCoordinatesToGlobal3DPosition(coordinates:Vector2,planetCenter:Vector3,planetRadius:int) -> Vector3:
	var localPosition = planetCoordinatesToLocal3DPosition(coordinates)
	return (localPosition * planetRadius) + planetCenter




## THE localPosition whuld be without the terrain value 
func localPositionToCoordinates(localPosition:Vector3,planetRadius:int) -> Vector2:

	var y = (localPosition.y / planetRadius)
	var altitudeDegree =  rad2deg(asin(y)) 
	var x = ((localPosition.x * (cos(deg2rad(altitudeDegree)) +1 )) / planetRadius) * 90
	var z = ((localPosition.z * (cos(deg2rad(altitudeDegree)) +1 )) / planetRadius) * 90
	var amplitudeDegree = rad2deg(atan2(z,x))

	return Vector2(amplitudeDegree, altitudeDegree)


# a new function using the normalisation and being more perfomrant

func localPositionToCoordinates2(localPosition:Vector3) -> Vector2:

	localPosition = localPosition.normalized()

	var altitudeDegree = rad2deg(asin(localPosition.y)) 

	var a = (cos(deg2rad(altitudeDegree)) + 1 ) * 90

	var amplitudeDegree = rad2deg(atan2((localPosition.z * a),(localPosition.x * a)))

	return Vector2(amplitudeDegree, altitudeDegree)
	




func globalPositionToCoordinates(globalPosition:Vector3, planetCenterPosition:Vector3) -> Vector2:
	return localPositionToCoordinates2((globalPosition - planetCenterPosition))



func createCosLinealTable(detail:int):
	var cosPoints = {}

	var intervalFragment = HALF_PI / detail
	for i in range(detail / 2):
		var x = i*intervalFragment
		var y = cos(x)
		cosPoints[x] = y
	
	# here we create the mirror negative part of the cosinPoints
	var negativeCosinPart = {}
	var negativeCoisinKeys = []
	var negativeCosinValues = cosPoints.values()

	for key in cosPoints.keys():
		negativeCoisinKeys.append(-key)
	
	negativeCoisinKeys.invert()
	negativeCosinValues.invert()

	for i in range(detail / 2):
		negativeCosinPart[negativeCoisinKeys[i]] = negativeCosinValues[i]
	

	negativeCosinPart.merge(cosPoints)

	return negativeCosinPart





## the pointA shuld be the lowest and b the bigger
## points values shuld be in rads
## the points shuld be the altidude
func getCosAverage(cosTable:Dictionary, pointA:float, pointB:float):
	
	var cosTablekeys = cosTable.keys()

	var intervalLongitude = abs(cosTablekeys[1])

	if abs(pointA - pointB) < intervalLongitude:
		return cos(pointA)

	var pointAValue = cos(pointA)
	var pointBValue = cos(pointB)

	var indexA = 0
	var indexB = 0


	var cosTableKeysRange = range(0,cosTablekeys.size())
	for i in cosTableKeysRange:
		if cosTablekeys[i] > pointA:
			indexA = i
			break

	for i in cosTableKeysRange:
		if pointB < cosTablekeys[i]:
			indexB = i -1
			break

	
	var totalIntervalValues = cosTable.values().slice(indexA, indexB)

	var limitAValue = cosTable[cosTablekeys[ indexA - 1]]
	var limitBValue = cosTable[cosTablekeys[ indexB + 1]]

	var differencePointALimit = pointAValue - limitAValue
	var differencePointBLimit = limitBValue - pointBValue


	var intervalAverage = 0

	for value in totalIntervalValues:
		intervalAverage += value
	intervalAverage = intervalAverage / totalIntervalValues.size()

	var factorLimitA = (differencePointALimit / intervalLongitude) 
	var factorLimitB = (differencePointBLimit / intervalLongitude) 

	var cosAverage = factorLimitA * differencePointALimit + factorLimitB * differencePointBLimit + intervalAverage

	return cosAverage





# func sinAverage(radValueA:float, radValueB:float) -> float:
# 	# the ia give me the next formula, i am not sure if it makes sense
# 	return (-2 / (radValueB - radValueA)) * (cos(radValueB) - cos(radValueA))
# 	pass

func getDistance(amplitudeDiference:float, altitudeDiference:float, cosAverage:float):

	var p1 = pow((altitudeDiference), 2)
	var p2 = pow((amplitudeDiference) * cosAverage ,2)

	return sqrt( p1 + p2 )



func getFullDistance(coordinateA:Vector2,coordinateB:Vector2, cosTable:Dictionary):

	var cosAverage = getCosAverage(cosTable,deg2rad(coordinateA.y),deg2rad(coordinateB.y))

	var altitudeDiference = coordinateB.y - coordinateA.y
	var amplitudeDiference = coordinateB.x - coordinateA.x
	
	return getDistance(amplitudeDiference, altitudeDiference, cosAverage)

func getGeoDesicDistance(coordinateA:Vector2,coordinateB:Vector2):	
	# stolen implementation from:https://code.activestate.com/recipes/576779-calculating-distance-between-two-geographic-points/

	var d_alt = coordinateB.y - coordinateA.y
	var d_amp = coordinateB.x - coordinateA.x
	var a = pow(sin(d_alt/2),2) + cos(coordinateA.y) * cos(coordinateB.y) * pow(sin(d_amp/2),2)
	# var c = 2 * atan2(sqrt(a), sqrt(1-a))
	return 2 * atan2(sqrt(a), sqrt(1-a))
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
