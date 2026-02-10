extends CharacterBody2D

var player: Node2D = null

var speed: float = 0.0
var health: float = 0.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var enemy_data: EnemyData

func setup(data: EnemyData) -> void:
	enemy_data = data
	
func _ready():
	add_to_group("enemies")
	# Find the player in the Main scene
	# 'owner' refers to the root of the scene this node is in
	player = get_tree().current_scene.find_child("Player")
	if enemy_data:
		speed = enemy_data.speed
		health = enemy_data.base_health
		sprite.play("default")

func _physics_process(_delta):
	if player:
		# Vector math: (Target - Me).normalized()
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func take_damage(amount: float):
	health -= amount	
	sprite.modulate = Color.RED
	get_tree().create_timer(0.1).timeout.connect(func(): sprite.modulate = Color.WHITE)
	if health <= 0:
		die()
		
func die():
	# TODO: drop xp gem
	queue_free()
