extends Node2D

@onready var timer: Timer = $Timer

var data: WeaponData

func setup(weapon_data: WeaponData) -> void:
	data = weapon_data
	timer.wait_time = data.cooldown
	timer.start()
	
func _on_timer_timeout() -> void:
	fire()

func fire() -> void:
	var target = get_nearest_enemy()
	if target == null:
		return
		
	# spawn projectile
	var projectile = data.projectile_node.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	projectile.global_position = global_position
	
	# inject stats into the projectile
	var direction = (target.global_position - global_position).normalized()
	if projectile.has_method("launch"):
		projectile.launch(direction, data.speed, data.damage, data.lifespan)
		
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
		
