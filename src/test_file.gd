extends MeshInstance

var generation = load("res://src/generation/3d_generation.gd").new()

func _ready():
	var visualSphere = generation.generateXdistantVectorSphere(10,60)
	var colisionSphere = generation.generateXdistantVectorSphere(10,10)

	var mesh = generation.createMesh(visualSphere["vertexes"], visualSphere["indexes"])
	var colisionMesh = generation.createMeshNoNormals(colisionSphere["vertexes"], colisionSphere["indexes"])

	print("js")
	var save = ResourceSaver.save("res://data/generatedData/mesh.res",mesh)
	print("hola")
	print(save)
	var loads = ResourceLoader.load("res://data/generatedData/messh.res","ArrayMesh")

	print("load")
	var loadsss = loads == null
	print( loadsss)
	print(mesh)

	print("disaster!")
	self.mesh = loads

	
