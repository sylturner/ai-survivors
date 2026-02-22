extends Resource
class_name PlayerStats

@export_group("Offense")
# [attr]_multi are multipliers (2.0 = 2x) or percentage modifiers (0.1 = 10% more)
# [attr]_add are adders
@export_subgroup("Multipliers")
@export var damage_multi: float = 0.0
@export var area_multi: float = 0.0
@export var cooldown_multi: float = 0.0
@export var projectile_speed_multi: float = 0.0
@export var knockback_multi: float = 0.0
@export var lifespan_multi: float = 3.0
@export var pierce_multi: float = 0.0
@export_subgroup("Adders")
@export var damage_add: float = 0.0
@export var area_add: float = 0.0
@export var cooldown_add: float = 0.0
@export var projectile_count_add: float = 0.0
@export var projectile_speed_add: float = 0.0
@export var knockback_add: float = 0.0
@export var lifespan_add: float = 3.0
@export var pierce_add: float = 0.0
@export_subgroup("Critical Hits")
@export var crit_chance: float = 0.05
@export var crit_multi: float = 2.0

@export_group("Defense")
@export var max_health: float = 100.0
@export var armor: int = 0
@export var dodge_chance: float = 0.0
@export var luck: float = 1.0 # multiplier for rolls
