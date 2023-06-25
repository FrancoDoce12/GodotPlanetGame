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
	#print("ejecucion func ready")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var noiseGeneration = load("res://src/generation/noise_generation.gd").new()

	noiseGeneration.interestinNoiseTest()

	pass

func _process(_delta):
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
