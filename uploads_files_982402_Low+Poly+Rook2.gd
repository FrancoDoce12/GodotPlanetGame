extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var math = load("res://src/main/math/utils.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_uploads_files_982402_LowPolyRook_followBlueRook():
	var psotition = self.get_parent().previusPosition

	var coordinates = math.localPositionToCoordinates(psotition)
	
	self.global_transform.basis = Vector3(0, -deg2rad(coordinates.x), deg2rad(coordinates.y -90))
	self.global_transform.origin = psotition

	self.scale = (Vector3(0.04,0.04,0.04))
	pass # Replace with function body.
