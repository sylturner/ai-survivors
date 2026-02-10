extends CharacterBody2D

@export var speed: float = 400.0
@export var friction: float = 0.15 # 0 to 1 (lower is slipperier)
@export var acceleration: float = 0.2
#@export var projectile_scene: PackedScene = preload("res://Scenes/Projectiles/Projectile.tscn")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# This ignores collisions and physics properties entirely
	# It manipulates the raw X/Y coordinates of the node
	position += direction * speed * delta

#func _on_timer_timeout() -> void:
	#fire()
	
#func fire():
	#var bullet = projectile_scene.instantiate()
	#
	#get_tree().current_scene.add_child(bullet)
	#bullet.global_position = global_position
	#
	#var fire_direction = velocity.normalized()
	#if fire_direction == Vector2.ZERO:
		#fire_direction = Vector2.RIGHT
		#
	#bullet.direction = fire_direction
