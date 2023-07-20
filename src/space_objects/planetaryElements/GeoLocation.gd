extends Spatial

class_name GeoLocation

var coordinates:Vector2 = Vector2(0,0)

# the colision radius of the object in the plane, 0 by default for objects with no radius
var radius:float = 0

# the direcion angle of the element
var direction:float = 0

var parentPlanet:Planet 

# Called when the node enters the scene tree for the first time.
func _ready():
	parentPlanet = get_parent()




func teleport(coordinates:Vector2,gloabalPosition:Vector3):
	self.global_transform.origin = gloabalPosition
	self.global_transform.basis = Vector3(direction, -deg2rad(coordinates.x), deg2rad(coordinates.y -90))
	self.coordinates = coordinates

func teleportCoordinates(coordinates:Vector2):
	var position = math.planetCoordinatesToGlobal3DPosition(coordinates, parentPlanet.transform.origin, parentPlanet.radius)
	teleport(coordinates, position)

func teleportPosition(globalPosition:Vector3):
	var localPosition = globalPosition - parentPlanet.transform.origin 
	var coordinates = math.localPositionToCoordinates(localPosition,parentPlanet.radius)

	teleport(coordinates,localPosition)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
