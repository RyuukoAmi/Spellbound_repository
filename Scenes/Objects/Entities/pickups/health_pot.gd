extends Area3D

var collected = false
var health_value = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if not collected:
		if body.get_name() == "Player":
			body.modify_health(health_value, false)
			collected = true
	if collected:
		queue_free()
