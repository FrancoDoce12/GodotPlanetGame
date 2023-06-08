class_name Planet_mesh_instance extends MeshInstance
var generation = load("res://src/generation/utils.gd").new()
var mainUtils = load("res://src/main/utils.gd").new()
var database = load("res://src/main/database.gd").new()

var radius =20
export(int) var radiuss = 0 setget _create_mesh

var detail = 5
export(bool) var update = false setget _update_scene

func _ready():
	mainUtils.test(self,generation.generateQuarterSphereMesh(radius,detail))
	self.mesh = generation.generateQuarterSphereMesh(radius,detail)
	# self.add_child()
	

func _create_mesh(_int):
	print(_int,detail,radius,radiuss )
	self.mesh = generation.generateQuarterSphereMesh(radiuss,detail)

func _update_scene(_b):
	self.mesh = generation.generateQuarterSphereMesh(radius,detail)
