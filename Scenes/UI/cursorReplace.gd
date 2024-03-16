extends Node


# Load the custom images for the mouse cursor.
var arrow = load("res://Sprites/UI/goldencursor.png")


func _ready():
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(arrow)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
