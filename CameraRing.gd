extends Spatial

# ------------------------------ Start of Variables ------------------------------

var sensitivity = 0.1
var zoom_speed = 5
var min_zoom = 1
var max_zoom = 10
var movement_speed = 5
# --------------- planet camera vars ---------------
var planetCenter = Vector3(0,0,0)
var planetZoom = 4
# angleA is the Vertical coordinate of the planet
var angleA = 0
# angleB is the Horizontal coordinate of the planet
var angleB = 0
var planetRadius:int
# --------------- camera modes vars ---------------
# posibles camera modes: "space", "planet"
var cameraMode = "space"
var currentMouseMananger:FuncRef
var currentMovementMananger:FuncRef



# ------------------------------ Start of Functions ------------------------------
# 1  Planet Functions:
# 2  Space Functions:
# 3  camera modes functions:
# 4  godot build in functions:


# --------------- 1 Planet Functions ---------------
func mouseManangerPlanet(_event):
	# for now it do not have to change anithing here
	pass
func movementManangerPlanet(delta):
	# EXPLANAITION, 
	# The movment in the planet is all manange by the coordinates angles of the planet the movment of the camera
	# its the movment of their coordinates and then calculate the exact point using trigonometry of the vector 3d of the camera
	var angleMovmentA = 0
	var angleMovmentB = 0
	if Input.is_action_pressed("move_forward"):
		angleMovmentA += 1
	if Input.is_action_pressed("move_backward"):
		angleMovmentA -= 1
	if Input.is_action_pressed("move_left"):
		angleMovmentB -= 1
	if Input.is_action_pressed("move_right"):
		angleMovmentB += 1
	
	angleMovmentA = angleMovmentA * delta * movement_speed
	angleMovmentB = angleMovmentB * delta * movement_speed
	
	angleA += angleMovmentA
	angleB += angleMovmentB
	var planetPosition = Vector3()
	# the "planetPosition" vector shuld be the the position of the camera in relation of the planet center (0,0,0)
	planetPosition.x = cos(deg2rad(angleA))
	planetPosition.y = sin(deg2rad(angleA))
	planetPosition.z = sin(deg2rad(angleB))
	planetPosition = planetPosition.normalized()

	planetPosition = (planetPosition * (planetRadius + planetRadius / planetZoom)) 
	# the "planetCenter" shuld be the center of the planet in relation of the 3d world
	var finalPosition = planetCenter + planetPosition
	
	self.translate(finalPosition)

# --------------- 2 Space Functions ---------------
func mouseManangerSpace(event):
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
	

func movementManangerSpace(delta):
	var dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		dir.z += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	dir = dir.normalized() * delta * movement_speed
	self.translate(dir)


# --------------- 3 camera modes functions ---------------

func changeToSpaceMode():
	currentMouseMananger = funcref(self,"mouseManangerSpace")
	currentMovementMananger = funcref(self,"movementManangerSpace")
func changeToPlanetMode(planetRadius_:int, planetCenter_:Vector3):
	planetCenter = planetCenter_
	planetRadius = planetRadius_

	currentMouseMananger = funcref(self,"mouseManangerPlanet")
	currentMovementMananger = funcref(self,"movementManangerPlanet")

# --------------- 4 godot build in functions ---------------

func _ready():
	changeToSpaceMode()
	# match cameraMode:
	# 	"space":
	# 		changeToSpaceMode()
	# 	"planet":
	# 		changeToPlanetMode()



func _input(event):
	currentMouseMananger.call_func(event)

func _process(delta):
	currentMovementMananger.call_func(delta)
