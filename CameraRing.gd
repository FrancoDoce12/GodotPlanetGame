extends Spatial

# EXPLANAITIONS:
# This camera is coded to work with diferents modes


# ------------------------------ Start of Variables ------------------------------

var math = load("res://src/main/math/utils.gd").new()

var sensitivity = 0.1
var zoom_speed = 5
var min_zoom = 1
var max_zoom = 10
var movement_speed = 5
# --------------- planet camera vars ---------------
var planetCenter = Vector3(0,0,0)
var planetMovmentSpeed = 10
var planetMinZoom = 0.20
var planetZoomSpeed = 0.30
var planetZoom = 5
var planetMaxZoom = 40
var planetIsAcelerating = false

# --------------- planet coordinates vars ---------------

# al -> Altitude is the degree of the altitude of the camera, its important that the minimun value what can be is -35 and the max value is 35
var al:float = 0.0

# am -> Amplitude is a degree of the amplitude in with the camira is standing
var am:float = 0.0
var planetRadius:int
# --------------- camera modes vars ---------------
# posibles camera modes: "space", "planet"
var cameraMode = "space"
var currentMouseMananger:FuncRef
var currentMovementMananger:FuncRef

# --------------- signals declarations ---------------

signal debugSignal(text)

# --------------- debug vars ---------------


## those vars are the points clicked on the planet
var actualPoint:Vector3 = Vector3(0,0,0)

var previusPoint:Vector3 = Vector3(0,0,0)


# ------------------------------ Start of Functions ------------------------------
# 1  Planet Functions:
# 2  Space Functions:
# 3  camera modes functions:
# 4  godot build in functions:


# --------------- 1) The Planet Functions ---------------
func mouseManangerPlanet(event):


	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

	if event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP:
		planetZoom = clamp(planetZoom + planetZoomSpeed, planetMinZoom, planetMaxZoom)
	elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN:
		planetZoom = clamp(planetZoom - planetZoomSpeed, planetMinZoom, planetMaxZoom)
	


func movementManangerPlanet(delta):
	# EXPLANAITION, 
	# The movment in the planet is all manange by the coordinates angles of the planet the movment of the camera
	# its the movment of their coordinates and then calculate the exact point using trigonometry of the vector 3d of the camera

	if Input.is_action_pressed("aceletare_movment"):
		planetIsAcelerating = !planetIsAcelerating
		planetMovmentSpeed = 10 + (20 * planetIsAcelerating)



	var altitude:float = 0.0
	var amplitude:float = 0.0
	if Input.is_action_pressed("move_forward"):
		altitude += 1
	if Input.is_action_pressed("move_backward"):
		altitude -= 1
	if Input.is_action_pressed("move_left"):
		amplitude += 1
	if Input.is_action_pressed("move_right"):
		amplitude -= 1

	# make a var that acelerates the amplitude change in the poles
	
	altitude = altitude * delta * planetMovmentSpeed
	al = clamp(altitude + al, -89, 89 )
	

	# do we need this aceleration for the poles becouse in the poles the camera gose slower than in the center and to mainten that aceleration constan trow all the planet we added the aceleration amplitde
	var amplitudeAceleration = abs(sin(deg2rad(al))) + 1
	
	amplitude = amplitude * delta * planetMovmentSpeed * amplitudeAceleration
	am += amplitude 
	
	
	
	self.rotation_degrees = Vector3(-al,-am+90,0)
	
	# the "planetPosition" vector shuld be the the position of the camera in relation of the planet center (0,0,0)
	var planetPosition = Vector3()
	
	planetPosition.y = sin(deg2rad(al))
	planetPosition.z = sin(deg2rad(am)) * cos(deg2rad(al))
	planetPosition.x = cos(deg2rad(am)) * cos(deg2rad(al))
	
	
	planetPosition = (planetPosition * (planetRadius + planetRadius / planetZoom)) 
	# the "planetCenter" shuld be the center of the planet in relation of the 3d world
	var finalPosition = planetCenter + planetPosition
	
	var text1 = str(al) + " -altitude" + "\n" + str(am) + " -amplitude" + "\n" + str(sin(deg2rad(al))) + " -sin(al)" + "\n"
	var text2 = str(sin(deg2rad(am))) + " -sin(am)" + "\n" + str(cos(deg2rad(al))," -cos(al)") + str(cos(deg2rad(am))," -cos(am)")
	var text3 = str("\n", planetPosition.y," -y,\n ",planetPosition.z," -z\n",planetPosition.x," -x")
	var text4 = str("\nDISTANCE: ",planetCenter.distance_to(finalPosition))
	var test6 = str("\n", amplitudeAceleration, " - amplitudAceleration ")
	emit_signal("debugSignal",text1+text2+text3+text4+test6)
	
	
	self.global_translation = finalPosition
	

# --------------- 2 Space Functions ---------------
func mouseManangerSpace(event):

	if event is InputEventMouseButton:
		# this pice of code makes whan you click it puts the mouse at the center of the screen
		# to acctualy makes the click viable while in mouse mode captured 
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				var windowCenter = OS.get_window_safe_area().get_center()
				get_viewport().warp_mouse(windowCenter)
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event is InputEventMouseMotion:
		var rot = self.rotation_degrees
		rot.x -= event.relative.y * sensitivity
		rot.y -= event.relative.x * sensitivity
		self.rotation_degrees = rot
	# elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_UP:
	# 	var pos = self.translation
	# 	pos.z -= zoom_speed
	# 	pos.z = clamp(pos.z, -max_zoom, -min_zoom)
	# 	self.translation = pos
	# elif event is InputEventMouseButton and event.button_index == BUTTON_WHEEL_DOWN:
	# 	var pos = self.translation
	# 	pos.z += zoom_speed
	# 	pos.z = clamp(pos.z, -max_zoom, -min_zoom)
	# 	self.translation = pos


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



func _on_Planet_planet_selected(planetNode):
	changeToPlanetMode(planetNode.radius,planetNode.global_translation)

	pass # Replace with function body.


func _on_UI_goToPlanetButton():
	

	changeToSpaceMode()
	self.global_transform.origin = planetCenter
	var postition = self.get_parent().actualPosition
	var lastPositonCoord = math.localPositionToCoordinates(postition, planetRadius)
	self.global_transform.basis = Vector3(lastPositonCoord.y,lastPositonCoord.x,0)
	pass # Replace with function body.
