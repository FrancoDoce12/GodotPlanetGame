extends MeshInstance
var utils = load("res://src/generation/utils.gd")
var utilsInstance = utils.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.mesh = utilsInstance.test().mesh
	
	#var material = SpatialMaterial.new()
	#material.albedo_color = Color(0.8, 0.8, 0.8)  # Color base del material
	#material.metallic = 0.5  # Nivel de reflexión metálica del material
	#material.roughness = 0.5  # Nivel de rugosidad del material
	#self.mesh.material = material



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
