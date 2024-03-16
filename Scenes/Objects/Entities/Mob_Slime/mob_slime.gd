extends CharacterBody3D#MOB_BAT

var health = 35
var dead = false
var DAMAGE = 15
var knockback_timer = 0.0
var knockback_velocity = 0.0

const movement_speed = 5.0
var movement_target_position: Vector3 = Vector3(-3.0,0.0,2.0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var page_scene = preload("res://Scenes/Objects/Entities/pickups/page_drop.tscn")
@onready var player_vars = get_node ("/root/playerGlobals")
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 1
	navigation_agent.target_desired_distance = 1
	# Make sure to not await during _ready.
	call_deferred("actor_setup")
	
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector3):
	await get_tree().physics_frame
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	
	if health <= 0:
		dead = true
		$AnimatedSprite3D.play("death")
		await get_tree().create_timer(0.8).timeout
		drop_items()
		queue_free()
	if not dead:
		if knockback_timer > 0.0:
			velocity = knockback_velocity * delta
			knockback_velocity = knockback_velocity * 0.9
			$AnimatedSprite3D.play("hurt")
			knockback_timer -= delta
		else:
			do_pathfinding()
			$AnimatedSprite3D.play("attack")
	move_and_slide()
	
func drop_items():
	var did_drop = randf_range(0.0, 1.0)
	#print(did_drop)
	if did_drop <= player_vars.drop_rate:
		var drop = page_scene.instantiate()
		add_sibling(drop)
		drop.global_transform = $CollisionShape3D.global_transform
	
	
func do_pathfinding():
	if navigation_agent.is_navigation_finished():
		return
	set_movement_target(player_vars.player_location) 
	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed

func modify_health(damage_value, is_damage = true, knockback_strength = 0, source_vector = velocity):
	knockback_velocity = knockback_strength * source_vector * 10
	knockback_timer = knockback_strength * 0.25
	#print(knockback_timer)
	if is_damage:
		health -= damage_value
	else:
		health += damage_value
	

func _on_Mousover_event(_camera, _event, where, _normal, _shape_idx):
	player_vars.cursor_pointing = where
