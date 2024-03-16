extends Control
var is_pause_menu = false
@onready var player_vars = get_node ("/root/playerGlobals")
@onready var upgrade_menu_scene = preload("res://Scenes/UI/menus/menu_upgrades.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		GameManager.toggle_pause()
		toggle_pause()
	if Input.is_action_just_pressed("ui_down"):
		print('health down')
		player_vars.current_health -= 5
	if Input.is_action_just_pressed("ui_up"):
		print('health up')
		player_vars.current_health += 5
	status_update()

func toggle_pause():
	is_pause_menu = not is_pause_menu
	if is_pause_menu:
		$PauseMenu.show()
		#Control.MOUSE_FILTER_PASS
	else:
		$PauseMenu.hide()
		#Control.MOUSE_FILTER_IGNORE

func status_update():
	$StatusContainer/HealthBar.value = player_vars.current_health

func upgrade_menu():
	print('ui upgrade')

func _on_resume_button_pressed():
	GameManager.toggle_pause()
	toggle_pause()

func quit_to_title():
	GameManager.save_game()
	GameManager.toggle_pause()
	toggle_pause()
	print('quit to title')
	get_tree().change_scene_to_file("res://Scenes/UI/menus/menu_title.tscn")
