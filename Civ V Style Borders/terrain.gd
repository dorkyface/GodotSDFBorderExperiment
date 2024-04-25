extends Node3D

@export var meshI : MeshInstance3D
@onready var shad : ShaderMaterial = meshI.mesh.surface_get_material(0)
@onready var pointNodes = get_tree().get_nodes_in_group("POINT")

# Called when the node enters the scene tree for the first time.
func _ready():
	#The UV doesn't start at 0.0, it starts from the corner of the mesh.
	#The shader has a scale offset parameter that compensates for the difference
	#Provided that the mesh remains at (0,0)
	shad.set_shader_parameter("scale_offset", meshI.mesh.size.x / 2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Updates the list of positions every frame.
	set_all_border_positions()

func set_all_border_positions():
	var posi = []
	for i in pointNodes.size():
		#Creates a vector4 where the first 3 values are the xyz positions of a nodepoint
		#The w value is the radius of the border around the node.
		var tmp = Vector4(pointNodes[i].global_position.x, pointNodes[i].global_position.y, pointNodes[i].global_position.z, pointNodes[i].radius)
		posi.append(tmp)
	
	#Passes all node positions with radii to the shader.
	shad.set_shader_parameter("positions", posi)
