extends Node

var ability_data
var default_save_data
var custom_save_data

func _ready():
	print("---imported abilities---")
	import_ability()
	print("---imported save defaults---")
	import_default_save()
	print("---imported custom Save---")
	import_custom_save()

func import_ability():
	var save_game = FileAccess.open("res://DATA/baseDATA/ability_data.json", FileAccess.READ)
	var json_string
# Check if the file is successfully opened
	if not save_game:
		print("Failed to open file.")
	else:
		json_string = save_game.get_as_text()

	# Close the file after reading
	save_game.close()

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

func import_default_save():
	var save_game = FileAccess.open("res://DATA/baseDATA/player_default_save.json", FileAccess.READ)
	var json_string
# Check if the file is successfully opened
	if not save_game:
		print("Failed to open file.")
	else:
		json_string = save_game.get_as_text()

	# Close the file after reading
	save_game.close()

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

func import_custom_save():
	var save_game = FileAccess.open("res://DATA/baseDATA/player_custom_save.json", FileAccess.READ)
	var json_string
# Check if the file is successfully opened
	if not save_game:
		print("Failed to open file.")
	else:
		json_string = save_game.get_as_text()

	# Close the file after reading
	save_game.close()

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

func load_game():
	pass


func save_game():
	var save_game = FileAccess.open("user://save_data.json", FileAccess.WRITE)

# Check if the file is successfully opened
	if not save_game:
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
		var json = JSON.new()

		# Convert the data to a JSON string
		var json_string = json.print(data_to_save)

		# Write the JSON string to the file
		save_game.store_string(json_string)

		# Close the file after writing
		save_game.close()

		print("Data saved successfully.")

