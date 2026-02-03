extends Node2D

# --- Configuration ---
@export var waves: Array[SpawnWave] = []
@export var spawn_radius: float = 750.0

# --- State ---
var time_elapsed: float = 0.0
var active_waves: Array[SpawnWave] = []
var player: Node2D = null

@onready var timer: Timer = $Timer
   
func _ready() -> void:
	# Find the player in the scene tree
	player = get_tree().current_scene.find_child("Player")
	
	# Connect the timer signal via code to ensure it's hooked up
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _process(delta: float) -> void:
	time_elapsed += delta
	_update_active_waves()

## Filters the waves array to find which definitions are valid for the current game time
func _update_active_waves() -> void:
	active_waves.clear()
	for wave in waves:
		if time_elapsed >= wave.start_time and time_elapsed <= wave.end_time:
			active_waves.append(wave)

func _on_timer_timeout() -> void:
	if active_waves.is_empty() or player == null:
		return
	
	# 1. Pick a random active wave (e.g., if you have overlapping time windows)
	var current_wave = active_waves.pick_random()
	
	# 2. Update timer frequency based on the wave's specific interval
	if timer.wait_time != current_wave.spawn_interval:
		timer.wait_time = current_wave.spawn_interval
	
	# 3. Pick a specific enemy based on weighted probability
	var enemy_data = _pick_weighted_enemy(current_wave.enemies)
	
	# 4. Spawn it
	if enemy_data:
		spawn_enemy(enemy_data)

## Standard weighted random algorithm
func _pick_weighted_enemy(enemies: Array[EnemyData]) -> EnemyData:
	var total_weight = 0
	for e in enemies:
		total_weight += e.spawn_weight
	
	var roll = randi() % total_weight
	var cursor = 0
	for e in enemies:
		cursor += e.spawn_weight
		if roll < cursor:
			return e
	return enemies[0]

func spawn_enemy(data: EnemyData) -> void:
	var scene = data.get_scene()
	if !scene:
		return
	
	# Instantiate the scene defined in our Resource
	var enemy_instance = scene.instantiate()
	
	# Inject the Data Resource into the Enemy before it enters the Scene Tree
	if enemy_instance.has_method("setup"):
		enemy_instance.setup(data)
	
	# Add to Main scene so enemies don't move with the spawner/player
	get_tree().current_scene.add_child(enemy_instance)
	
	# Calculate position in a circle around the player
	var random_angle = randf() * TAU
	var spawn_offset = Vector2(cos(random_angle), sin(random_angle)) * spawn_radius
	enemy_instance.global_position = player.global_position + spawn_offset
