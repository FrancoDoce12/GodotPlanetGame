extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("ejecucion func ready")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
