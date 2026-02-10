extends Node2D

@export var weapon_base_scene: PackedScene = preload("res://Scenes/Weapons/Weapon.tscn")

@export var starting_weapons: Array[WeaponData] = []
@export var available_weapons: Array[WeaponData] = []

func _ready() -> void:
	for data in starting_weapons:
		add_weapon(data)
		
func add_weapon(data: WeaponData) -> void:	
	var weapon_scene = data.get_scene()
	if not weapon_scene:
		print("ERROR: No scene found for ", data.name)
		return
		
	var new_weapon = weapon_scene.instantiate()
	new_weapon.setup(data)
	
	add_child(new_weapon)
