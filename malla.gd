extends MeshInstance


class Line:
	var vartices:int

	func _init(vartices_:int):
		vartices = vartices_

var rng = RandomNumberGenerator.new()

var lines = 4

var lines_array = []

func ojete():
	return 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

	for line in lines:
		# i = index
		
		var new_line = Line.new(rng.randi_range(2,6))
		lines_array.append(new_line)

	for i in range(lines_array.size()):
		#i = the index
		#var line = lines_array[i]
		print(i)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
