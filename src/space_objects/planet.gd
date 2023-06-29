extends MeshInstance

var radius = 5
var detail = 70
var collisionDetail = 10

var lastCameraAngleA = 0
var lastCameraAngleB = 0

var heigthSeed = randi()



# adds the sphere mesh to self.mesh
func getMesh()-> void:
	var mesh: Mesh
	var collisionMesh: Mesh

	var meshPath = "res://data/generatedData/sphereMesh-{radius}-{detail}.res"
	meshPath = meshPath.format({"radius":radius,"detail":detail})

	var collisionPath = "res://data/generatedData/sphereMesh-{radius}-colision.res"
	collisionPath = collisionPath.format({"radius":radius})

	mesh = ResourceLoader.load(meshPath,"ArrayMesh")
	collisionMesh = ResourceLoader.load(collisionPath,"ArrayMesh")


	# if the mesh  does not exists, generate it
	if (mesh == null) or (collisionMesh == null):
		var generation = load("res://src/generation/3d_generation.gd").new()

		var meshInfo = generation.generateXdistantVectorSphere(radius, detail)
		var collisionInfo = generation.generateXdistantVectorSphere(radius,collisionDetail)

		mesh = generation.createMesh(meshInfo["vertexes"],meshInfo["indexes"])
		collisionMesh = generation.createMeshNoNormals(collisionInfo["vertexes"],collisionInfo["indexes"])

		var _b = ResourceSaver.save(meshPath,mesh)
		var _a = ResourceSaver.save(collisionPath,collisionMesh)
	self.mesh = mesh




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
