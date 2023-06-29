extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		get_tree().quit()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				var windowCenter = OS.get_window_safe_area().get_center()
				get_viewport().warp_mouse(windowCenter)
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func mauseModeCenter():
	pass

func mouseModeClick():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	print(cos(deg2rad(230)), " cos 230")
	print(cos(deg2rad(-90)), " cos -90")
	pass

func _process(_delta):
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CameraRing_debugSignal(text):
	pass # Replace with function body.
