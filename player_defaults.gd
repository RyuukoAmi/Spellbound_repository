extends Node

var player_health = 100
var cursor_pointing = Vector3(1,1,0)
var player_location

#player upgradeable values:
var max_health = 100
var damage_reduction = 0.00
var mana_regen = 5.0
var equiped_1_mana = 100
var equiped_2_mana = 100


#base weapon stats, writen in dictionaries
# values are: name, damage, accuracy, crit_chance, mana_cost
var MELEE = {"name": "Bonk", "damage":10, "accuracy":1,"crit_chance":0.1, "mana_cost":0}
var PISTOL = {"name": "Ardor", "damage":15, "accuracy":0.8, "crit_chance":0.1, "mana_cost":5, "bullet_speed":18, "bullet_color": Color(1,0,0), "bullet_knockback": 1}
