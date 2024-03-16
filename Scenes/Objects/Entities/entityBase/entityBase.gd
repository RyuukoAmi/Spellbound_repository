#INFO ------BASE ENTITY CLASS FOR EASIER ABILITY IMPLEMENTATION

extends CharacterBody3D
class_name Entity_Player

#INFO --- Health Variables
var max_health : int = 100
var current_health :int = 100
var dead : bool = false
var health_regen : float = 0.0
var armor : int = 0

#INFO --- Mana varables
#----for if we actualy implement manna...

#INFO --- Movement variables
var SPEED : int = 10
var speed_multiplier : float = 1.0
var DASH : int = 20
var dash_multiplier : float = 1.0
var dash_cooldown : float = 10

#INFO --- Animated sprite 3D varables
var viewportCenter = Vector2(1,1)
var cursorLoc = Vector2(1,1)
var charFacing
var spriteFacing
var bullet_aim

#INFO --- Equiped weapons
var primary_equiped = "MELEE"
var secondary_equiped = "PISTOL"

#INFO --- ability levels
var melee_level : int = 1
var pistol_level : int = 0
#non-weapon ability levels
var dash_level : int = 1
var movement_level : int = 0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var player_vars = get_node ("/root/playerGlobals")

func _ready():
	pass


func _physics_process(delta):
	char_facing()
	char_movement(delta)
	
	move_and_slide()
	is_dead()

#INFO --- all derivative functions
func is_dead():
	if current_health <= 0:
		print("player dead")
		get_tree().change_scene_to_file("res://Scenes/UI/menus/menu_gameOver.tscn")

func modify_health(damage_value, is_damage = true, _knockback_value = 0, _knockback_location = 0):
	if is_damage:
		player_vars.current_health -= damage_value
	else:
		player_vars.current_health += damage_value

func regen_health():
	modify_health(health_regen, false)

func regen_mana():
	#modify_mana(mana_regen)
	pass

func modify_mana(mana_value, is_additive = true):
	if is_additive:
		player_vars.current_mana += mana_value
	else:
		player_vars.current_mana -= mana_value

func _on_area_collision(body):
	if body.is_in_group("mobs"):
		print('player collided with mob')
		modify_health(body.DAMAGE)

func char_movement(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_backward", "move_forward", "move_left", "move_right")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if Input.is_action_just_pressed("dash"):
		
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
	viewportCenter = (get_viewport().get_visible_rect().size) / 2
	cursorLoc = get_viewport().get_mouse_position()
	
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
		spriteFacing = "S"
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
		spriteFacing = "N"
		#print("Facing North East")
	#print(charFacing)
	if velocity.length() == 0:
		$AnimatedSprite3D.play("idle_" + spriteFacing)
	else:
		$AnimatedSprite3D.play("Run_" + spriteFacing)
