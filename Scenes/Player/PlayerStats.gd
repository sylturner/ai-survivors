extends Resource
class_name PlayerStats

@export_group("Offense")
# [attr]_mod are percentage modifiers (e.g. 1.1 = 10% more)
# [attr]_count are whole numbers
# [attr]_multi are multipliers (e.g. 2.0 = 2x more)
@export var damage_mod: float = 1.0
@export var area_mod: float = 1.0
@export var projectile_speed_mod: float = 1.0
@export var projectile_count: int = 0
@export var cooldown_mod: float = 1.0
@export var crit_chance: float = 0.05
@export var crit_multi: float = 2.0

@export_group("Defense")
@export var max_health: float = 100.0
@export var armor: int = 0
@export var dodge_chance: float = 0.0
@export var luck: float = 1.0 # multiplier for rolls
