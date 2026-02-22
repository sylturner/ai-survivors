extends CharacterBody2D

@export var speed: float = 400.0
@export var friction: float = 0.15 # 0 to 1 (lower is slipperier)
@export var acceleration: float = 0.2

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# This ignores collisions and physics properties entirely
	# It manipulates the raw X/Y coordinates of the node
	position += direction * speed * delta
