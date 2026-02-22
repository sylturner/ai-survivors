extends Resource
class_name WeaponLevel

@export_multiline var description: String = "[Update level description text here]"

@export_group("Flat Additions")
@export var damage_add: float = 0.0
@export var area_add: float = 0.0
@export var projectile_count_add: float = 0.0
@export var projectile_speed_add: float = 0.0
@export var cooldown_add: float = 0.0
@export var pierce_add: float = 0.0
@export var knockback_add: float = 0.0
@export var lifespan_add: float = 0.0
@export var orbit_distance_add: float = 0.0
@export var orbit_speed_add: float = 0.0
@export var zone_radius_add: float = 0.0

@export_group("Multipliers (0.1 = +10%)")
@export var damage_multi: float = 0.0
@export var area_multi: float = 0.0
@export var projectile_count_multi: float = 0.0
@export var projectile_speed_multi: float = 0.0 
@export var cooldown_multi: float = 0.0         # use negatives to speed up cooldown -0.1 = 10% faster
@export var knockback_multi: float = 0.0
@export var lifespan_multi: float = 0.0
@export var orbit_distance_multi: float = 0.0
@export var orbit_speed_multi: float = 0.0
@export var zone_radius_multi: float = 0.0
