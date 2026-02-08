shader_type canvas_item;

uniform sampler2D _ScreenTexture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec2 screen_uv = SCREEN_UV;
	vec4 screen_texture = texture(_ScreenTexture, screen_uv);
	screen_texture.rgb *= vec3(1.0, 0.0, 0.0);
	COLOR = screen_texture;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
