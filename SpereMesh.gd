extends MeshInstance
var utils = load("res://src/generation/utils.gd")
var utilsInstance = utils.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.mesh = utilsInstance.test().mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
