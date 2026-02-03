extends Node2D

@export var weapon_base_scene: PackedScene = preload("res://Scenes/Weapons/Weapon.tscn")

@export var starting_weapons: Array[WeaponData] = []

func _ready() -> void:
	for data in starting_weapons:
		add_weapon(data)
		
func add_weapon(data: WeaponData) -> void:
	var new_weapon = weapon_base_scene.instantiate()
	add_child(new_weapon)
	new_weapon.setup(data)
	
