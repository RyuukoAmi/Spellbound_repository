extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var SPEED = 10
var viewportCenter = Vector2(1,1)
var cursorLoc = Vector2(1,1)
var charFacing
var spriteFacing
var bullet_aim
var attack_cooldown_timer = 0.0
var current_animation = "idle_E"
var last_animation = "idle_E"
var is_invulnerable = false
var invulnerable_timer = 0.0
var dash_cooldown_timer = 2.0

@onready var bullet_scene = preload("res://Scenes/Objects/Projectiles/bullet.tscn")
@onready var player_vars = get_node("/root/playerGlobals")




func _ready():
	print("player loaded")

func _physics_process(delta):
	
	viewportCenter = (get_viewport().get_visible_rect().size) / 2
	cursorLoc = get_viewport().get_mouse_position()
	
	char_movement(delta)#handles character movement in relation to the buttons
	char_facing()#Handles character sprite selection in relation to the mouse position in viewport
	char_aiming()#Handles character shooting direction in relation to raycast from camera
	player_vars.player_location = global_position
	# Handle Shoot.
	if Input.is_action_just_pressed("melee_attack"):
		shoot('melee')
	if Input.is_action_just_pressed("primary_action"):
		primary_action()
	#if Input.is_action_just_pressed("secondary_action"):
		#secondary_action()
	if Input.is_action_just_pressed("dash"):
		print("dash")
		dash()
	
	if dash_cooldown_timer >= 0.4: # reset speed after dash length
		SPEED = player_vars.base_speed
	
	move_and_slide()
	run_animation()

	if player_vars.current_health <=0 :
		print("player dead")
		get_tree().change_scene_to_file("res://Scenes/UI/menus/menu_gameOver.tscn")
	attack_cooldown_timer += delta
	dash_cooldown_timer += delta
	invulnerable_timer -= delta
	if invulnerable_timer <= 0.00:
		is_invulnerable = false
	

func char_movement(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_backward", "move_forward", "move_left", "move_right")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func char_facing():
	#_______________ INFO _________________
	#character facing direction
	#print(cursorLoc)
	#print(viewportCenter)
	charFacing = cursorLoc.angle_to_point(viewportCenter)
	#print(charFacing)
	if ((charFacing < (-2.7)) or (charFacing > 2.7)):
		spriteFacing = "E"
		#print("Facing East")
	elif ((charFacing > (-2.7)) and (charFacing < (-2.0))):
		spriteFacing = "E"
		#print("Facing South East")
	elif ((charFacing > (-2.0)) and (charFacing < (-1.2))):
		spriteFacing = "S"
		#print("Facing South")
	elif ((charFacing > (-1.2)) and (charFacing < (-0.4))):
		spriteFacing = "W"
		#print("Facing South West")
	elif ((charFacing > (-0.4)) and (charFacing < (0.4))):
		spriteFacing = "W"
		#print("Facing West")
	elif ((charFacing > (0.4)) and (charFacing < (1.2))):
		spriteFacing = "W"
		#print("Facing North West")
	elif ((charFacing > (1.2)) and (charFacing < (2.0))):
		spriteFacing = "N"
		#print("Facing North")
	elif ((charFacing > (2.0)) and (charFacing < (2.7))):
		spriteFacing = "E"
		#print("Facing North East")
	#print(charFacing)
	if velocity.length() == 0:
		current_animation = ("idle_" + spriteFacing)
	else:
		current_animation = ("Run_" + spriteFacing)

func char_aiming():
	var looking_at = player_vars.cursor_pointing
	looking_at.y = $bullet_fire_point.position.y
	$bullet_fire_point.look_at(looking_at,Vector3(0, 1, 0), true)

func primary_action():
	print("primary_action")
	shoot(player_vars.equiped_1)

func secondary_action():
	print("secondary_action")
	shoot(player_vars.equiped_1)

func run_animation():
	if is_invulnerable:
		$AnimatedSprite3D.play("hurt")
	elif "dash" in current_animation:
		if $AnimatedSprite3D.get_frame() < 3:
			$AnimatedSprite3D.play(last_animation)
		else:
			$AnimatedSprite3D.play(current_animation)
			last_animation = current_animation
	elif "melee" in last_animation:
		if $AnimatedSprite3D.get_frame() < 3:
			$AnimatedSprite3D.play(last_animation)
		else:
			$AnimatedSprite3D.play(current_animation)
			last_animation = current_animation
	elif "spell" in last_animation:
		if $AnimatedSprite3D.get_frame() < 3:
			$AnimatedSprite3D.play(last_animation)
		else:
			$AnimatedSprite3D.play(current_animation)
			last_animation = current_animation
	else: 
		$AnimatedSprite3D.play(current_animation)
		last_animation = current_animation

func shoot(attack):
	
	check_equiped_level()
	if GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["ability_cooldown"] <= attack_cooldown_timer:
		attack_cooldown_timer = 0
		#char_aiming()
		var projectile = bullet_scene.instantiate()
		projectile.BULLET_SPEED = GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["attack_bullet_speed"]
		projectile.BULLET_DAMAGE = GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["attack_damage"]
		projectile.BULLET_COLOR = GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["attack_bullet_color"]
		projectile.BULLET_CRIT_CHANCE = GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["attack_crit_chance"]
		projectile.BULLET_KILL_TIMER = GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["attack_bullet_life"]
		projectile.BULLET_KNOCKBACK = GameManager.ability_data[str(attack) + str(player_vars.equiped_level)]["attack_knockback"]
		projectile.BULLET_TYPE = str(attack) + str(player_vars.equiped_level)
		add_sibling(projectile)
		projectile.global_transform = $bullet_fire_point.global_transform
		#--- INFO --- sprite animation for attacks
		var attack_sprite
		
		attack_sprite = spriteFacing
		if attack == "melee":
			current_animation = ("melee_" + str(attack_sprite))
		else:
			current_animation = ("spell_" + str(attack_sprite))

func dash():
	if not (player_vars.dash_level == 0):
		if GameManager.ability_data["dash" + str(player_vars.dash_level)]["ability_cooldown"]<= dash_cooldown_timer:
			dash_cooldown_timer = 0.0
			SPEED = float(GameManager.ability_data["dash" + str(player_vars.dash_level)]["ability_distance"])
			current_animation = ("dash_" + spriteFacing)

func check_equiped_level():
	match player_vars.equiped_1:
		"melee":
			player_vars.equiped_level = player_vars.melee_level
		"pistol":
			player_vars.equiped_level = player_vars.pistol_level
	
func modify_health(damage_value, is_damage = true, _knockback_value = 0, _knockback_direction = velocity):
	if is_damage:
		if is_invulnerable:
			pass
		else:
			player_vars.current_health -= damage_value
			is_invulnerable = true
			invulnerable_timer = 0.6
			pass
	else:
		player_vars.current_health += damage_value

func modify_mana(mana_value, is_positive = true):
	if is_positive:
		player_vars.current_mana += mana_value
	else:
		player_vars.current_mana -= mana_value

func _on_area_3d_body_entered(body):
	if body.is_in_group("mobs"):
		print('player collided with mob')
		modify_health(body.DAMAGE)
