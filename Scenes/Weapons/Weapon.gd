extends Node2D
class_name Weapon

var data: WeaponData
var current_level: int = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var timer: Timer = $Timer
@onready var muzzle: Marker2D = find_child("Muzzle")

func setup(weapon_data: WeaponData) -> void:
	data = weapon_data

func get_stat(stat: String) -> float:
	# get base val	
	var base_value = data.get(stat)
	var total_add = 0.0
	var total_multi = 1.0 # 1.0 = 100% to start
		
	# add level bonus
	for i in range(current_level - 1):
		if i < data.levels.size():
			var lvl = data.levels[i]
			total_add += lvl.get(stat + "_add") or 0.0
			total_multi += lvl.get(stat + "_multi") or 0.0
	
	# add player bonuses
	if player and player.stats:
		total_add += player.stats.get(stat + "_add") or 0.0
		total_multi += player.stats.get(stat + "_multi") or 0.0
		
	var value = (base_value + total_add) * total_multi
	return value
	
func generate_damage_event() -> DamageEvent:
	var event = DamageEvent.new()
	var final_dmg = get_stat("damage")
	
	if randf() < (player.stats.crit_chance * player.stats.luck):
		event.is_critical = true
		final_dmg *= player.stats.crit_multi
		
	event.base_damage = final_dmg
	event.knockback_force = get_stat("knockback")
	return event

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
		
