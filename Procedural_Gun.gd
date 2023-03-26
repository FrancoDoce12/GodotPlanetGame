extends MeshInstance
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var total_surface_array = []
	
	total_surface_array.resize(Mesh.ARRAY_MAX)
	
	var primera_cara = PoolVector3Array(
		[		#	x  y  z
			Vector3(0, 0, 0),
			Vector3(1, 0, 0),
			Vector3(1, 1, 0),
			Vector3(0, 1, 0),
			
		]
	)
	
	var primera_cara_index =  PoolIntArray([
		0,1,2,
		0,2,3,
	])
	
# warning-ignore:unused_variable
	var segunda_cara = PoolVector3Array(
		[		#	x  y  z
			Vector3(0, 0, 1),
			Vector3(1, 0, 1),
			Vector3(1, 1, 1),
			Vector3(0, 1, 1),
			
		]
	)
	
	total_surface_array[ArrayMesh.ARRAY_VERTEX] = primera_cara
	
	
	total_surface_array[ArrayMesh.ARRAY_INDEX] = primera_cara_index
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, total_surface_array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
