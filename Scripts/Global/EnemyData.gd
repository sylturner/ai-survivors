extends Resource
class_name EnemyData

@export var name: String = "Enemy"
@export var base_health: float = 10.0
@export var speed: float = 150.0
@export var spawn_weight: int = 10

const FALLBACK_SCENE_PATH = "res://Scenes/Enemies/Enemy.tscn"
var cached_scene: PackedScene

func get_scene() -> PackedScene:
	if cached_scene:
		return cached_scene
		
	var enemy_name = resource_path.get_file().get_basename()
	var scene_path = "res://Scenes/Enemies/" + enemy_name + ".tscn"
	
	if ResourceLoader.exists(scene_path):
		cached_scene = load(scene_path)
		return cached_scene
		
	if ResourceLoader.exists(FALLBACK_SCENE_PATH):
		push_warning("Unable to find scene path " + scene_path)
		cached_scene = load(FALLBACK_SCENE_PATH)
		return cached_scene
	
	push_error("Dynamic loading failed: No scene found at " + scene_path)
	return null
	
