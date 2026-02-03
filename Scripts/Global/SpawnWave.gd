extends Resource
class_name SpawnWave

@export_group("Timeline")
@export var start_time: float = 0.0 # Seconds into the run
@export var end_time: float = 60.0

@export_group("Spawning")
@export var enemies: Array[EnemyData]
@export var spawn_interval: float = 1.0
@export var is_boss_wave: bool = false
