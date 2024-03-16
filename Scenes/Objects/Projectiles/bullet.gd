extends Area3D

var BULLET_SPEED = 18
var BULLET_DAMAGE = 10
var BULLET_TYPE = "default"
var BULLET_TEAM = "friendly"
var BULLET_COLOR = Color(1, 0, 1)
var BULLET_CRIT_CHANCE = 0
var BULLET_KNOCKBACK = 0

@warning_ignore("integer_division")
var BULLET_KILL_TIMER = (100/ BULLET_SPEED)
var timer = 0

var hit_something = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$OmniLight3D.light_color = Color.from_string(BULLET_COLOR, Color(1,1,1,0))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#------------------
	#move bullet forward
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * BULLET_SPEED * delta)
	#------------------
	#No forever bullets
	timer += delta
	if timer>= BULLET_KILL_TIMER:
		queue_free()
	
	#-------------------
	#animated bullets
	$AnimatedSprite3D.play(BULLET_TYPE)
	

func collided(body):
	if hit_something == false:
		if body.get_name() == "Player" :
			if BULLET_TEAM == "friendly":
				#print("friendly bullet hit " + body.get_name()) #passthrough
				pass
			elif body.has_method('modify_health'):
				body.modify_health(BULLET_DAMAGE, true, BULLET_KNOCKBACK, global_transform.basis.z.normalized() * BULLET_SPEED)
				#print("unfriendly bullet hit " + body.get_name()) 
				hit_something = true
				queue_free()
		elif BULLET_TEAM == "unfriendly":
			#print("unfriendly bullet hit " + body.get_name()) #passthrough
			pass
		elif body.has_method('modify_health'):
			body.modify_health(BULLET_DAMAGE, true, BULLET_KNOCKBACK, global_transform.basis.z.normalized() * BULLET_SPEED)
			#print("friendly bullet hit " + body.get_name()) 
			hit_something = true
			queue_free()
		else:
			hit_something = true
			queue_free()
