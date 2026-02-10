extends Node2D
class_name Weapon

@onready var timer: Timer = $Timer
@onready var muzzle: Marker2D = find_child("Muzzle")

var data: WeaponData

func setup(weapon_data: WeaponData) -> void:
	data = weapon_data

func _ready() -> void:
	if data:
		print("Timer starting for: ", data.name)
		timer.wait_time = data.cooldown
		timer.one_shot = false
		timer.start()
	else:
		print("Warning: Weapon reached _ready but has no data!")

func _on_timer_timeout() -> void:
	fire()

func fire() -> void:
	if not data or not data.projectile_node:
		return

	var target = get_nearest_enemy()
	if not target:
		return

	# spawn projectile
	var projectile = data.projectile_node.instantiate()
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position

	# inject stats into the projectile
	var direction = (target.global_position - global_position).normalized()
	projectile.launch(direction, data.speed, data.damage, data.lifespan, data.death_effect)

func get_nearest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.is_empty(): return null
	
	var nearest = null
	var min_dist = INF
	for enemy in enemies:
		var d = global_position.distance_squared_to(enemy.global_position)
		if d < min_dist:
			min_dist = d
			nearest = enemy
	return nearest
		
