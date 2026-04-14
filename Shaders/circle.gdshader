shader_type canvas_item;

uniform vec4 ringColour : source_color;
uniform vec4 borderColour : source_color;
uniform float ringWidth : hint_range(0.0, .5) = .1;
uniform float borderWidth : hint_range(0.0,.25) = .1;
uniform float progress : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec2 center = UV - vec2(.5);
	float dist = length(center);
	float angle = mod((atan(center.y, center.x) / (2.0 * PI)) +.25, 1.0);
	bool ring = (dist <= 0.5 && dist > 0.5 - ringWidth);
	bool border = (
		dist > 0.5 - borderWidth ||
		dist < (0.5 - ringWidth) + borderWidth ||
		angle<borderWidth * 0.3 && progress < 1.0||
		abs(angle - progress) < borderWidth * 0.3 && progress < 1.0
		);
	
	if (ring && angle <= progress) {
		if (border) {
			 COLOR = borderColour;
		}
		else {
			COLOR = ringColour;
		} 
	}
	else {
		COLOR.a = 0.0;
	}
}
