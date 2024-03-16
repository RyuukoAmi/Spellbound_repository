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
	get_tree().change_scene_to_file("res://Scenes/Objects/Enviornment/Levels/level02.tscn")


func _on_load_pressed():
	print("main menu load button pressed")
	GameManager.import_custom_save()
	GameManager.load_game()
	get_tree().change_scene_to_file("res://Scenes/Objects/Enviornment/Levels/level02.tscn")
