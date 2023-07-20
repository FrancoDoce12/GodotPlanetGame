extends Spatial


var planetSelected:bool = false

# var isMouseOnPlanet: bool = false
signal planet_selected(childNode)
signal put_object(position)
signal debug_click(text)

func _on_Area_input_event(camera:Node, event:InputEvent, position:Vector3, normal:Vector3, shape_idx:int):

	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT:
			if !planetSelected:
				var childNode = get_child(0)
				planetSelected = true
				emit_signal("planet_selected", childNode)
			else:
				emit_signal("put_object", position)
				# var relativePosition = self.global_translation - position
				# var a = 1 / radius
				# var b = 1 / 90
				pass
				
				# var altitude = relativePosition.y * a * b 
				# var text = str(position," 3d position\n",normal," the normal\n",shape_idx, " shape_idx int \n",altitudeDegree," altitudeDegree\n",amplitudeDegree, " amplitudeDegree\n",x," X\n",z," Z\n")

				# emit_signal("debug_click", text)


func positionToDegrees(position:Vector3):

	# makes the global position to a relative position of the center of the planet
	position -= get_child(0).global_translation

	# in the future i will have to substract the terrain value form the position

	var r = get_child(0).radius
	var altitudeDegree = (position.y / r) * 90
	var x = ((position.x * (cos(deg2rad(altitudeDegree)) +1 )) / r) * 90
	var z = ((position.z * (cos(deg2rad(altitudeDegree)) +1 )) / r) * 90
	var amplitudeDegree = rad2deg(atan2(z,x))

	return Vector2(amplitudeDegree, altitudeDegree)

func degreeToPosition(degreeCoordinates:Vector2)-> Vector3:
	var newPosition = Vector3()
	var r = get_child(0).radius
	var al = degreeCoordinates.y
	var am = degreeCoordinates.x

	newPosition.y = sin(deg2rad(al))
	newPosition.z = sin(deg2rad(am)) * cos(deg2rad(al))
	newPosition.x = cos(deg2rad(am)) * cos(deg2rad(al))

	# in the future i will have to add the terrain to the return value

	return (newPosition * r) + get_child(0).global_translation



	
func outlinePlanet() -> void:
	
	pass


