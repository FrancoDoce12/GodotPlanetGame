extends Node

var planetSize:int
var planetRadius:int


func getPosition(angleA:float,angleB:float):
	var x = cos(deg2rad(angleA)) * planetRadius
	var y = sin(deg2rad(angleA)) * planetRadius
	var z = sin(deg2rad(angleB)) * planetRadius
	return Vector3(x,y,z)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
