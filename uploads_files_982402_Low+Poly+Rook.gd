extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal followBlueRook(planetNode)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var isPlaced = false


func _on_Planet_put_object(coordinates,planetNode,position):
	# self.transform.scaled( Vector3(0.01,0.01,0.01) ) 
	self.global_transform.basis = Vector3(0, -deg2rad(coordinates.x), deg2rad(coordinates.y -90))
	self.global_transform.origin = planetNode.degreeToPosition(coordinates) 
	# print(isPlaced)
	# # if isPlaced:
	# # 	self.global_transform.origin = position
	# # else:
	# # 	var coordinatess = planetNode.positionToDegrees(position)
	# # 	var newPos = planetNode.degreeToPosition(coordinatess)
	# # 	self.global_transform.origin = newPos
	
	# if isPlaced:
	# 	planetNode.moveObject
	
	# isPlaced = false

	self.scale = (Vector3(0.04,0.04,0.04))

	# Replace with function body.
	emit_signal("followBlueRook",planetNode)

