extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal goToPlanetButton 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_CameraRing_debugSignal(text):
	$DebugText.text = text
	pass # Replace with function body.


func _on_Planet_debug_click(text):
	$DebugClick.text = text
	$DebugClick.add_color_override("font_color",Color.red)
	pass # Replace with function body.


func _on_GoToPlanetCenter_pressed():
	emit_signal("goToPlanetButton")
	pass # Replace with function body.
