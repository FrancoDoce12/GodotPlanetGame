extends Domain

class_name Settlement



func _init(owner:Ent, campaing_model:MeshInstance, population:int, society:String).(owner,campaing_model):
	self.population = population
	self.society = society
