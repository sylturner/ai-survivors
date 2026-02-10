extends Projectile

func _process(delta: float) -> void:
	super._process(delta) # Keep the movement logic
	$AnimatedSprite2D.rotation += delta * 15.0 # Make it spin!
