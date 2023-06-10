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

# adds the sphere mesh to self.mesh
func getMesh()-> void:
	var mesh: Mesh
	var path = "res://data/generatedData/sphereMesh{radius}-{detail}.res"
	path = path.format({"radius":radius,"detail":detail})

	mesh = ResourceLoader.load(path,"ArrayMesh")
	if mesh == null:
		var generation = load("res://src/generation/3d_generation.gd").new()
		var meshInfo = generation.generateXdistantVectorSphere(radius, detail)
		mesh = generation.createMesh(meshInfo["vertexes"],meshInfo["indexes"])
		generation.free()
		ResourceSaver.save(path,mesh)
	
	self.mesh = mesh


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
