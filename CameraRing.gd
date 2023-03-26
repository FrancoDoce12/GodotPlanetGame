extends Spatial

var sensitivity = 0.1
var zoom_speed = 5
var min_zoom = 1
var max_zoom = 10

func _input(event):
	if event is InputEventMouseMotion:
		var rot = self.rotation_degrees
		rot.x -= event.relative.y * sensitivity
		rot.y -= event.relative.x * sensitivity
		self.rotation_degrees = rot
	elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP:
		var pos = self.translation
		pos.z -= zoom_speed
		pos.z = clamp(pos.z, -max_zoom, -min_zoom)
		self.translation = pos
	elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN:
		var pos = self.translation
		pos.z += zoom_speed
		pos.z = clamp(pos.z, -max_zoom, -min_zoom)
		self.translation = pos

func _process(delta):
	var dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		dir.z += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	dir = dir.normalized() * delta * zoom_speed
	self.translate(dir)
