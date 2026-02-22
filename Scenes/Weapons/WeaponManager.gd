extends Node2D

@export var weapon_base_scene: PackedScene = preload("res://Scenes/Weapons/Weapon.tscn")

@export var starting_weapons: Array[WeaponData] = []
@export var available_weapons: Array[WeaponData] = []

var active_weapons = {}

func _ready() -> void:
	for data in starting_weapons:
		add_weapon(data)
		
func add_weapon(data: WeaponData) -> void:	
	# If weapon is already active, level it up!
	if active_weapons.has(data.name):
		active_weapons[data.name].level_up()
		return
	
	var weapon_scene = data.get_scene()
	if not weapon_scene:
		print("ERROR: No scene found for ", data.name)
		return
		
	var new_weapon = weapon_scene.instantiate()
	new_weapon.setup(data)
	
	active_weapons[data.name] = new_weapon
	
	add_child(new_weapon)
