extends Spatial

var math = load("res://src/main/math/utils.gd").new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# ---------------- global vars ----------------
var actualPosition:Vector3 = Vector3(0,0,0)
var previusPosition:Vector3 = Vector3(0,0,0)



func lastPosition (position:Vector3):
	actualPosition = previusPosition
	previusPosition = position


func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		get_tree().quit()
	
	

	
	

func mauseModeCenter():
	pass

func mouseModeClick():
	pass



# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _process(_delta):
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CameraRing_debugSignal(text):
	pass # Replace with function body.
