extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Game-Over Loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/menus/menu_title.tscn")

func _on_retry_pressed():
	print("main menu credits button pressed")
	GameManager.start_new_game()
	get_tree().change_scene_to_file("res://Scenes/Objects/Enviornment/Levels/level02.tscn")
