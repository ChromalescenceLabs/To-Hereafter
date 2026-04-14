shader_type canvas_item;

uniform sampler2D screenTexture : hint_screen_texture, filter_linear;
uniform vec2 center = vec2(0.5, 0.5); 
uniform float force = 0.1;
uniform float size;
uniform float thickness = 0.01;

void fragment() {
	float ratio = TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x;
	vec2 scaledUV = (UV - center) * vec2(ratio, 1.0) + center;
	float outerMask = (1.0 - smoothstep(size - 0.1, size, length(scaledUV - center)));
	float innerMask = smoothstep(size - thickness - 0.1, size - thickness, length(scaledUV - center));
	float mask = outerMask * innerMask;
	vec2 displace = normalize(scaledUV - center) * force * mask;
	vec4 screenColour = texture(screenTexture, SCREEN_UV - displace);
	//invert
	vec3 invertedColour = 1.0 - screenColour.rgb;
	COLOR.rgb = mix(invertedColour, screenColour.rgb, innerMask);
	COLOR.a = screenColour.a;
	//COLOR.rgb= vec3(mask);
}