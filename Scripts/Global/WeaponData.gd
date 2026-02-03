extends Resource
class_name WeaponData

@export var name: String = "Weapon"
@export var projectile_node: PackedScene
@export var texture: Texture2D
@export var damage: float = 5.0
@export var cooldown: float = 1.0
@export var speed: float = 600.0
@export var lifespan: float = 3.0
@export var death_effect: PackedScene
@export var projectile_frames: SpriteFrames
