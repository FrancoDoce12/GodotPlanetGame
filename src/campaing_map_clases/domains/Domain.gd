extends Spatial
class_name Domain 

# here we manange the ownership of the domain

var domain_owner: Ent

# var campaing_model: MeshInstance

func _init(owner:Ent, campaing_model:MeshInstance):
	add_child(campaing_model)

	self.domain_owner = owner
	owner.domains.append(self)
