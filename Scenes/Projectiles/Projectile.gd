extends Area2D

var speed: float = 0
var damage: float = 0
var direction: Vector2 = Vector2.ZERO
var death_effect: PackedScene

func launch(dir: Vector2, spd: float, dmg: float, life: float, death_fx: PackedScene ) -> void:
	direction = dir
	speed = spd
	damage = dmg
	death_effect = death_fx	
	
	rotation = direction.angle()
	
	get_tree().create_timer(life).timeout.connect(die)
	
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		die()
		

func die() -> void:
	if death_effect:
		var effect = death_effect.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = global_position
	queue_free()
