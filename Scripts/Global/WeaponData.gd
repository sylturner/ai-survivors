extends Resource
class_name WeaponData

@export_group("Metadata")
@export var name: String = "Weapon"
@export_multiline var description: String = "[Write your weapon description here]"

@export_group("Base Stats")
@export var damage: float = 5.0
@export var area: float = 1.0
@export var projectile_count: int = 1
@export var cooldown: float = 1.0
@export var projectile_speed: float = 600.0
@export var knockback: float = 5.0
@export var lifespan: float = 3.0
@export var pierce: int = 0 # number of enemies it can pass through

@export_group("Level Progression")
@export var levels: Array[WeaponLevel] = []

@export_group("Visuals")
@export var projectile_node: PackedScene
@export var texture: Texture2D
@export var death_effect: PackedScene
@export var projectile_frames: SpriteFrames


const FALLBACK_SCENE_PATH = "res://Scenes/Weapons/Weapon.tscn"
var cached_scene: PackedScene

func get_scene() -> PackedScene:
	if cached_scene:
		return cached_scene
		
	var weapon_name = resource_path.get_file().get_basename()
	var scene_path = "res://Scenes/Weapons/" + weapon_name + ".tscn"
	
	if ResourceLoader.exists(scene_path):
		cached_scene = load(scene_path)
		return cached_scene
		
	if ResourceLoader.exists(FALLBACK_SCENE_PATH):
		push_warning("Unable to find scene path " + scene_path)
		cached_scene = load(FALLBACK_SCENE_PATH)
		return cached_scene
	
	push_error("Dynamic loading failed: No scene found at " + scene_path)
	return null
	
