shader_type canvas_item;

uniform vec2 camera_pos;
uniform float height_factor : hint_range(0.0, 1.0) = 0.3;

void vertex() {
	vec2 world_origin = (MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xy;
	vec2 diff = world_origin - camera_pos;
	
	// Create a mask that is 1.0 for the center roof and 0.0 for the tips
	// Since your cross is perfectly centered, UV 0.5 is the middle
	float mask_x = smoothstep(0.0, 0.2, 0.5 - abs(UV.x - 0.5));
	float mask_y = smoothstep(0.0, 0.2, 0.5 - abs(UV.y - 0.5));
	
	// This 'plateau' ensures the center stays rigid
	float rigid_mask = pow(mask_x * mask_y, 2.0);
	
	VERTEX += diff * rigid_mask * height_factor;
}