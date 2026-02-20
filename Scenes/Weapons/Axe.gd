extends Weapon

@export var projectile_count: int = 3
@export var arc_angle: float = 60.0 # Total width of the arc in degrees


func fire() -> void:
	if not data or not data.projectile_node:
		return

	# Calculate the starting angle (half the arc to the left)
	var start_angle = -arc_angle / 2.0
	# Calculate how many degrees between each axe
	var angle_step = 0
	if projectile_count > 1:
		angle_step = arc_angle / (projectile_count - 1) 
		

	for i in range(projectile_count):
		var current_angle = start_angle + (angle_step * i)
		# We want the arc to be centered "UP" (-90 degrees in Godot)
		var spawn_direction = Vector2.UP.rotated(deg_to_rad(current_angle))
		
		spawn_axe(spawn_direction)

func spawn_axe(dir: Vector2) -> void:
	var proj = data.projectile_node.instantiate()
	get_tree().current_scene.add_child(proj)
	
	proj.global_position = muzzle.global_position if muzzle else global_position
	
	# Pass the axe-specific speed/damage from its WeaponData	
	proj.launch(dir, data.speed, data.damage, data.lifespan, data.death_effect)
