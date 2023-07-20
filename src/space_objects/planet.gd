extends MeshInstance

class_name Planet

var math = get_parent().math



var radius = 5
var detail = 70
var collisionDetail:float = detail * 0.2

var heigthSeed = randi()

var planetSelected:bool = false

var lastCameraAltitude = 0
var lastCameraAmplitude = 0

var planetCosTable = math.createCosLinealTable(400)

signal planet_selected(planetNode)
signal put_object(coordinates)
signal debug_click(text)

# a debug var storing a coordinate for placing objects in the planet, delete later
var debugCoordinate:Vector2 = Vector2(0, 0)

# start of math related functions

func planetDistance(coordinateA:Vector2,coordinateB:Vector2) -> float:
	return math.getDistance(coordinateA,coordinateB, planetCosTable)


func _on_Area_input_event(camera:Node, event:InputEvent, position:Vector3, normal:Vector3, shape_idx:int):

	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT:
			if !planetSelected:
				planetSelected = true
				emit_signal("planet_selected", self)
			else:
				if event.is_pressed():
					var coordinates = positionToDegrees(position)
					emit_signal("put_object", coordinates,self,position)


					var text = str(position," 3d position\n",debugCoordinate," previusCoordinates\n",coordinates.y," altitudeDegree\n",coordinates.x, " amplitudeDegree\n")
					debugCoordinate = coordinates
					emit_signal("debug_click", text)

					var parent = self.get_parent()
					parent.lastPosition(position)




func positionToDegrees(position:Vector3) -> Vector2:

	# makes the global position to a relative position of the center of the planet
	position -= global_translation
	

	# in the future i will have to substract the terrain value form the position
	var y = (position.y / radius)
	var altitudeDegree =  rad2deg(asin(y)) 
	var x = ((position.x * (cos(deg2rad(altitudeDegree)) +1 )) / radius) * 90
	var z = ((position.z * (cos(deg2rad(altitudeDegree)) +1 )) / radius) * 90
	var amplitudeDegree = rad2deg(atan2(z,x))

	return Vector2(amplitudeDegree, altitudeDegree)

func degreeToPosition(degreeCoordinates:Vector2)-> Vector3:
	var newPosition = Vector3()

	var al = degreeCoordinates.y
	var am = degreeCoordinates.x

	newPosition.y = sin(deg2rad(al))
	newPosition.z = sin(deg2rad(am)) * cos(deg2rad(al))
	newPosition.x = cos(deg2rad(am)) * cos(deg2rad(al))

	# in the future i will have to add the terrain to the return value

	return (newPosition * radius) + global_translation









# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass
	
	
	# adds the sphere mesh to self.mesh
	# ----------------------------- Unused funcs -----------------------------
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
