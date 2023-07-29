class Layer:
	var perm:Array
	var unit:float
	var complexity:int

	func _init(seed_:int, complexity:int):
		perm = math.create_random_list(seed_,complexity)
		perm.append_array(perm)

		self.complexity = complexity
		unit = 1.0 / complexity
	
	func gets(point:Vector2):
		var i = 1
		var dxPerm = perm[i]
		var dyPerm = perm[2*i]

		var x:int = int(point.x)
		var y:int = int(point.y)

		var u:float = point.x - x
		var v:float = point.y - y

		var yPerm = perm[(y + dyPerm) % complexity]
		var xPerm = perm[(x + dxPerm) % complexity]
		var y1Perm = perm[(y + 1 + dyPerm) % complexity]
		var x1Perm = perm[(x + 1 + dxPerm) % complexity]
		#

		var p00 = perm[xPerm 	  + yPerm]
		var p10 = perm[x1Perm	  + yPerm]
		var p01 = perm[xPerm 	  + y1Perm]
		var p11 = perm[x1Perm	  + y1Perm]


		# get the corresponding "random value" from -1 to 1
		var v00 = (p00 * unit) * 2 - 1.0
		var v10 = (p10 * unit) * 2 - 1.0
		var v01 = (p01 * unit) * 2 - 1.0
		var v11 = (p11 * unit) * 2 - 1.0

		# each contribution for each corner's value
		var vc00 = (-u + 1) * (-v + 1)
		var vc10 = 	 u		* (-v + 1)
		var vc01 = (-u + 1) *   v
		var vc11 =   u      *   v

		var result = (vc00 * v00) + (vc10 * v10) + (vc01 * v01) + (vc11 * v11)

		return result



		# class Layer:
		# 	var perm:Array
		# 	var unit:float
		# 	var complexity:float
		
		# 	func _init(seed_:int, complexity:int):
		# 		seed_ = 35164328
		# 		perm = math.create_random_list(seed_,complexity)
		# 		perm.append_array(perm)
		
		# 		self.complexity = complexity
		# 		unit = 1.0 / complexity
			
		# 	func gets(point:Vector2):
		# 		var i = 1
		# 		var dxPerm = perm[i]
		# 		var dyPerm = perm[2*i]
		
		# 		var x = int(point.x)
		# 		var y = int(point.y)
		
		# 		var u:float = point.x - x
		# 		var v:float = point.y - y
		
		# 		var yPerm = perm[y + dyPerm]
		# 		var xPerm = perm[x + dxPerm]
		# 		var y1Perm = perm[y + 1 + dyPerm]
		# 		var x1Perm = perm[x + 1 + dxPerm]
		
		# 		#
		
				
		# 		var eyPerm = perm[y + perm[dyPerm]]
		# 		var exPerm = perm[x + perm[dxPerm]]
		# 		var ey1Perm = perm[x + 1 + perm[dxPerm]]
		# 		var ex1Perm = perm[y + 1 + perm[dyPerm]]
		# 		#ddfs
		
		# 		var ep00 = perm[yPerm 	  + xPerm]
		# 		var ep10 = perm[x1Perm	  + xPerm]
		# 		var ep01 = perm[yPerm 	  + y1Perm]
		# 		var ep11 = perm[x1Perm	  + y1Perm]
		
		# 		var p00 = perm[yPerm 	  + xPerm]
		# 		var p10 = perm[x1Perm	  + yPerm]
		# 		var p01 = perm[yPerm 	  + x1Perm]
		# 		var p11 = perm[x1Perm	  + y1Perm]
		
		
		# 		# get the corresponding "random value" from -1 to 1
		# 		var v00 = (p00 * unit) * 2 - 1.0
		# 		var v10 = (p10 * unit) * 2 - 1.0
		# 		var v01 = (p01 * unit) * 2 - 1.0
		# 		var v11 = (p11 * unit) * 2 - 1.0
		
		# 		# each contribution for each corner's value
		# 		var vc00 = (-u + 1) * (-v + 1)
		# 		var vc10 = 	 u		* (-v + 1)
		# 		var vc01 = (-u + 1) *   v
		# 		var vc11 =   u      *   v
		
		# 		var result = (vc00 * v00) + (vc10 * v10) + (vc01 * v01) + (vc11 * v11)
		
		# 		return result
		
		
		







class InterestingNoise2:
	var rgn:RandomNumberGenerator



	func _init(seed_):
		rgn = RandomNumberGenerator.new()
		rgn.seed = seed_
