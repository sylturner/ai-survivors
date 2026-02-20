extends Camera3D

var camera_2d : Camera2D 

func _ready():
	# Wait a frame to make sure the Player scene is loaded
	await get_tree().process_frame
	# Find the 2D camera in the 'main_camera' group
	var cams = get_tree().get_nodes_in_group("main_camera")
	if cams.size() > 0:
		camera_2d = cams[0]

func _process(_delta):
	if camera_2d:
		var screen_size = get_viewport().get_visible_rect().size
		var pos_2d = camera_2d.get_screen_center_position()
		
		# Orthogonal size must match viewport height to keep 1:1 pixel ratio
		size = screen_size.y
		
		# Sync position
		global_position = Vector3(pos_2d.x, 10.0, pos_2d.y)
