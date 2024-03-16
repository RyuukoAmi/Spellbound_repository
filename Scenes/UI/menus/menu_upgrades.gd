extends Control

@onready var button1 = $MarginContainer/MarginContainer2/HBoxContainer/option_1/VBoxContainer/MarginContainer2/pick_option_1
@onready var label1 = $MarginContainer/MarginContainer2/HBoxContainer/option_1/VBoxContainer/MarginContainer/Label1
@onready var button2 = $MarginContainer/MarginContainer2/HBoxContainer/option_2/VBoxContainer/MarginContainer2/pick_option_2
@onready var label2 = $MarginContainer/MarginContainer2/HBoxContainer/option_2/VBoxContainer/MarginContainer/Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	pick_upgrade_option(label1, button1)
	pick_upgrade_option(label2, button2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pick_option_1_pressed():
	GameManager.upgrade_ability(button1.text.trim_prefix("upgrade "))
	GameManager.toggle_pause()
	queue_free()

func _on_pick_option_2_pressed():
	GameManager.upgrade_ability(button2.text.trim_prefix("upgrade "))
	GameManager.toggle_pause()
	queue_free()

func pick_upgrade_option(label, button):
	var num = randi_range(0,4)
	var options_array = ["melee", "pistol", "dash", "health", "armor"]
	label.text = "LABEL THAT SAYS ALL THE COOL STUFF ABOUT THE UPGRADE. THIS IS AN UPGRADE FOR " + options_array[num]
	button.text = "upgrade " + options_array[num]
