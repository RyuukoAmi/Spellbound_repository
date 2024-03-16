extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
@onready var player_vars = get_node("/root/playerGlobals")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_env_ground_circle_input_event(_camera, _event, where, _normal, _shape_idx):
	player_vars.cursor_pointing = where
	#print(where)
