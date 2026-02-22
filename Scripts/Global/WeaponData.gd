extends Resource
class_name WeaponData

enum WeaponType {
	PROJECTILE, # Shoots something to hit enemy (Wand, Axe)
	AURA,       # Area surrounding player to hit enemy (Garlic, Bible)
	MELEE,      # Appears, swings/stabs, disappears (Whips)
	ZONE,       # Spawns at specific spot (Santa Water, Lightning)
	CUSTOM      # Customize in the weapon's scripts 
}

enum MovementStyle {
	LINEAR,     # straight line (Knife)
	ARC,        # Tossed up and falls (Axe)
	ORBITAL,    # Circles player (Bible)
	BOOMERANG,  # Out and back (Cross)
	BOUNCE,     # Bounces off screen edges (Runetracer)
	STATIONARY, # Stays where it spawned (Garlic, Santa Water)
	CUSTOM      # Customize movement in the weapon's scripts
}

enum TargetLogic {
	CLOSEST_ENEMY,  # auto-aim (wand)
	FACE_DIRECTION, # direction player is facing (knife, whip)
	RANDOM_ENEMY,   # random enemy on screen (lightning)
	RANDOM_IN_ZONE, # random location within a defined area (peachone, santa water)
	CUSTOM
}

@export_group("Metadata")
@export var name: String = "Weapon"
@export_multiline var description: String = "[Write your weapon description here]"
@export var icon: Texture2D
@export var weapon_scene: PackedScene

@export_group("Behavior")
@export var type: WeaponType = WeaponType.PROJECTILE
@export var movement: MovementStyle = MovementStyle.LINEAR
@export var targeteting: TargetLogic = TargetLogic.CLOSEST_ENEMY

@export_group("Base Stats")
@export var damage: float = 5.0
@export var area: float = 1.0
@export var cooldown: float = 1.0
@export var projectile_count: int = 1
@export var projectile_speed: float = 600.0
@export var knockback: float = 5.0
@export var lifespan: float = 3.0
@export var pierce: int = 0 # number of enemies it can pass through

@export_group("Progression")
@export var levels: Array[WeaponLevel] = []

@export_group("Movement")
@export var orbit_distance: float = 100.0
@export var orbit_speed: float = 3.0
@export var zone_radius: float = 150.0

@export_group("Visuals")
@export var projectile_node: PackedScene
@export var texture: Texture2D
@export var death_effect: PackedScene
@export var projectile_frames: SpriteFrames


const FALLBACK_SCENE_PATH = "res://Scenes/Weapons/Weapon.tscn"
var cached_scene: PackedScene

func get_scene() -> PackedScene:
	# use the defined weapon scene when available
	if weapon_scene:
		return weapon_scene
	
	# use the auto-loaded weapon scene when available
	if cached_scene:
		return cached_scene
	
	# automagicically load the weapon scene
	var weapon_name = resource_path.get_file().get_basename()
	var scene_path = "res://Scenes/Weapons/" + weapon_name + ".tscn"
	
	if ResourceLoader.exists(scene_path):
		cached_scene = load(scene_path)
		return cached_scene
	
	# or default to the fallback weapon scene
	if ResourceLoader.exists(FALLBACK_SCENE_PATH):
		push_warning("Unable to find scene path " + scene_path)
		cached_scene = load(FALLBACK_SCENE_PATH)
		return cached_scene
	
	push_error("Dynamic loading failed: No scene found at " + scene_path)
	return null
	
func get_max_level() -> int:
	return levels.size() + 1
