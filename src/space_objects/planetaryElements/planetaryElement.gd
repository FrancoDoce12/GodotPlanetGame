extends GeoLocation

class_name PlanetaryElement


var turnMovment:int = 0
var mapSpeed:int = 0.1


# --------------------------- movment vars ---------------------------

var differenceCoordinate:Vector2 = Vector2(0,0)
var coordinateToMove:Vector2 = Vector2(0,0)

var distanceToMove:float = 0
var distanceTraveled:float = 0

var currentMovementMananger:FuncRef = funcref(self,"placeHolderFunction")




func moveTo(coordinates:Vector2):

	coordinateToMove = coordinates
	differenceCoordinate = coordinates - self.coordinates

	var cosAvrerage = math.getCosAverage(parentPlanet.planetCosTable ,deg2rad(self.coordinate.y), deg2rad(coordinates.y))

	distanceToMove = math.getDistance(differenceCoordinate.x, differenceCoordinate.y, cosAvrerage) * parentPlanet.radius

	currentMovementMananger = funcref(self,"process_moveTo")

	print(distanceToMove)


func process_moveTo(delta):
	distanceTraveled += mapSpeed * delta 

	if distanceTraveled >= distanceToMove:
		teleportCoordinates(coordinateToMove)
		currentMovementMananger = funcref(self,"placeHolderFunction")
		return

	var positionFactor = distanceTraveled / distanceToMove

	self.teleportCoordinates(differenceCoordinate * positionFactor)


func placeHolderFunction(_delta):
	return




func _init():
	pass

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentMovementMananger.call_func(delta)
	pass
