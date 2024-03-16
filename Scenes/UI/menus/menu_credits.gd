extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Credits Loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_back_pressed():
	print("Credits Back Pressed")
	get_tree().change_scene_to_file("res://Scenes/UI/menus/menu_title.tscn")

