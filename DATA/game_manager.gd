extends Node

var ability_data
var default_save_data
var custom_save_data
var game_paused : bool = false
var arrow = load("res://Sprites/UI/goldencursor.png")

func _ready(): #INFO working as intended
	Input.set_custom_mouse_cursor(arrow)
	print("---imported abilities---")
	import_ability()
	print("---imported save defaults---")
	import_default_save()
	print("---imported custom Save---")
	import_custom_save()
	#print(custom_save_data['max_health']["VALUE"])

func import_ability(): #INFO working as intended
	var saved_game = FileAccess.open("res://DATA/baseDATA/ability_data.json", FileAccess.READ)
	var json_string
# Check if the file is successfully opened
	if not saved_game:
		print("Failed to open file.")
	else:
		json_string = saved_game.get_as_text()

	# Close the file after reading
	saved_game.close()

	# Creates the helper class to interact with JSON
	var json = JSON.new()

	# Check if there is any error while parsing the JSON string
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message())
	else:
	# Get the data from the JSON object
		ability_data = json.get_data()

		# Now you can work with the parsed JSON data (node_data)

		
		for i in ability_data.keys():
			print(i)
		#print(ability_data)

func import_default_save(): #INFO working as intended
	var saved_game = FileAccess.open("res://DATA/baseDATA/player_default_save.json", FileAccess.READ)
	var json_string
# Check if the file is successfully opened
	if not saved_game:
		print("Failed to open file.")
	else:
		json_string = saved_game.get_as_text()

	# Close the file after reading
	saved_game.close()

	# Creates the helper class to interact with JSON
	var json = JSON.new()

	# Check if there is any error while parsing the JSON string
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message())
	else:
	# Get the data from the JSON object
		default_save_data = json.get_data()

		# Now you can work with the parsed JSON data (node_data)

		
		for i in default_save_data.keys():
			
			print(i)
		#print(default_save_data)

func import_custom_save(): #INFO working as intended
	var saved_game = FileAccess.open("res://DATA/baseDATA/player_custom_save.json", FileAccess.READ)
	#var saved_game = FileAccess.open("user://save_data.json", FileAccess.READ)
	var json_string
	# Check if the file is successfully opened
	if not saved_game:
		print("Failed to open file.")
	else:
		json_string = saved_game.get_as_text()

	# Close the file after reading
	saved_game.close()

	# Creates the helper class to interact with JSON
	var json = JSON.new()

	# Check if there is any error while parsing the JSON string
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message())
	else:
	# Get the data from the JSON object
		custom_save_data = json.get_data()

		# Now you can work with the parsed JSON data (node_data)

		
		for i in custom_save_data.keys():
			
			print(i)
		#print(custom_save_data)

func start_new_game(): #INFO working as intended
	custom_save_data = default_save_data
	print('custom save overwrite')
	load_game()

func load_game():#INFO working as intended
	print('load game data')
	playerGlobals.max_health = custom_save_data["max_health"]['VALUE']
	playerGlobals.current_health = custom_save_data["current_health"]['VALUE']
	playerGlobals.health_regen = custom_save_data["health_regen"]['VALUE']
	playerGlobals.max_mana = custom_save_data["max_mana"]['VALUE']
	playerGlobals.current_mana = custom_save_data["current_mana"]['VALUE']
	playerGlobals.mana_regen = custom_save_data["mana_regen"]['VALUE']
	playerGlobals.drop_rate = custom_save_data["drop_rate"]['VALUE']
	playerGlobals.equiped_1 = custom_save_data["equiped_1"]['VALUE']
	playerGlobals.melee_level = custom_save_data["melee_level"]['VALUE']
	playerGlobals.pistol_level = custom_save_data["pistol_level"]['VALUE']
	playerGlobals.dash_level = custom_save_data["dash_level"]['VALUE']
	playerGlobals.health_level = custom_save_data["health_level"]['VALUE']
	playerGlobals.mana_level = custom_save_data["mana_level"]['VALUE']
	playerGlobals.armor_level = custom_save_data["armor_level"]['VALUE']

func save_game(): #INFO working as intended
	var saved_game = FileAccess.open("user://save_data.json", FileAccess.WRITE)
	# Check if the file is successfully opened
	if not saved_game:
		print("Failed to open file.")
	else:
		# Your data to be saved
		var data_to_save = {
		"max_health": {
		"VALUE": playerGlobals.max_health
		},
		"current_health": {
		"VALUE": playerGlobals.current_health
		},
		"health_regen": {
		"VALUE": playerGlobals.health_regen
		},
		"max_mana": {
		"VALUE": playerGlobals.max_mana
		},
		"current_mana": {
		"VALUE": playerGlobals.current_health
		},
		"mana_regen": {
		"VALUE": playerGlobals.mana_regen
		},
		"drop_rate": {
		"VALUE": playerGlobals.drop_rate
		},
		"equiped_1": {
		"VALUE": playerGlobals.equiped_1
		},
		"melee_level": {
		"VALUE": playerGlobals.melee_level
		},
		"pistol_level": {
		"VALUE": playerGlobals.pistol_level
		},
		"dash_level": {
		"VALUE": playerGlobals.dash_level
		},
		"health_level": {
		"VALUE": playerGlobals.health_level
		},
		"mana_level": {
		"VALUE": playerGlobals.mana_level
		},
		"armor_level": {
		"VALUE": playerGlobals.armor_level
		}
		}

		# Creates the helper class to interact with JSON
		

		# Convert the data to a JSON string
		var json_string =JSON.stringify(data_to_save)

		# Write the JSON string to the file
		saved_game.store_line(json_string)

		# Close the file after writing
		saved_game.close()

		print("Data saved successfully.")

func toggle_pause(): #INFO working as intended
	game_paused = not game_paused
	get_tree().paused = game_paused

func toggle_upgrade(): #INFO working as intended
	toggle_pause()
	var menu = preload("res://Scenes/UI/menus/menu_upgrades.tscn")
	var path = get_node("/root/level02/UserInterface")
	print(path)
	path.add_child(menu.instantiate())

func upgrade_ability(ability):
	print("upgrading ", ability)
	var variable_string = ability + "_level"
	match variable_string:
		"melee_level":
			playerGlobals.melee_level +=1
		"pistol_level":
			playerGlobals.pistol_level +=1
		"dash_level":
			playerGlobals.dash_level +=1
		"health_level":
			playerGlobals.health_level +=1
		"mana_level":
			playerGlobals.mana_level +=1
		"armor_level":
			playerGlobals.armor_level +=1
		_:
			push_error("problem Upgrading Player D:")
