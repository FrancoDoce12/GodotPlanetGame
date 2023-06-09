extends MeshInstance

var radius = 5
var detail = 70

var lastCameraAngleA = 0
var lastCameraAngleB = 0

var heigthSeed = randi()


func getVectorPosition(angleA:int,angleB:int):
	var newPosition = Vector3()
	newPosition.x = cos(deg2rad(angleA)) * radius
	newPosition.y = sin(deg2rad(angleA)) * radius
	newPosition.z = sin(deg2rad(angleB)) * radius
	return newPosition

func getMesh():
	# TODO
	var _mesh = ResourceLoader.load("res://data/generatedData/sphereMesh.res","ArrayMesh")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
