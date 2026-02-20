extends Node2D

@export_group("Height Settings")
## How much the building 'leans'. Higher = Taller looking.
@export var height_scale: float = 0.1 
## How many layers to create between base and roof (for a 'solid' wall look)
@export var wall_segments: int = 5 

@onready var roof_sprite: Sprite2D = $Roof
@onready var base_position: Vector2 = Vector2.ZERO
#
#func _process(_delta: float) -> void:
	#var camera = get_viewport().get_camera_2d()
	#if not camera:
		#return
#
	## 1. Get the vector from the camera to the building
	## screen_center is the "focal point" of the perspective
	#var camera_pos = camera.get_screen_center_position()
	#var diff = global_position - camera_pos
	#
	## 2. Shift the Roof
	## The further from the center, the more it leans
	#roof_sprite.position = diff * height_scale
	#
	## 3. Handle the 'Walls' 
	## To avoid a floating roof, we need to fill the gap.
	## We can move any intermediate 'wall' layers proportionally.
	#_update_wall_segments(diff)
#
#func _update_wall_segments(diff: Vector2) -> void:
	## If you have children named 'Wall1', 'Wall2', etc.
	## This loop positions them in a line between the base and the roof
	#for i in range(1, wall_segments):
		#var segment = get_node_or_null("Wall" + str(i))
		#if segment:
			## Distribute the lean evenly
			#var percentage = float(i) / float(wall_segments)
			#segment.position = diff * (height_scale * percentage)
