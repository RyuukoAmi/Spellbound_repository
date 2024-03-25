extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Title Menu Loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_credits_pressed():
	#print("main menu credits button pressed")
	get_tree().change_scene_to_file("res://Scenes/UI/menus/menu_credits.tscn")


func _on_start_pressed():
	#print("main menu credits button pressed")
	GameManager.start_new_game()
	print('Loading new game, level_01')
	get_tree().change_scene_to_file("res://Scenes/Levels/level_01.tscn")


func _on_load_pressed():
	#print("main menu load button pressed")
	GameManager.import_custom_save()
	GameManager.load_game()
	print('Loading custom game,' + playerGlobals.current_level)
	get_tree().change_scene_to_file("res://Scenes/Levels/" + playerGlobals.current_level + ".tscn")
