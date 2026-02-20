extends Polygon2D

func _process(_delta: float) -> void:
	var camera = get_viewport().get_camera_2d()
	if camera:
		var cam_pos = camera.get_screen_center_position()
		# Update the "camera_pos" variable inside the shader
		material.set_shader_parameter("camera_pos", cam_pos)
