shader_type canvas_item;

uniform vec4 color;


void fragment() {
	COLOR = (vec4(mix(texture(TEXTURE,UV).rgb,color.rgb,color.a),texture(TEXTURE,UV).a));
	// Called for every pixel the material is visible on.
}
