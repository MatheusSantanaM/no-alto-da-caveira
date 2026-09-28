shader_type canvas_item;

uniform bool infected = false;
uniform float time_offset = 0.0;

float random(vec2 uv) {
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec2 uv = UV;
	if (infected) {
		float glitch = random(vec2(floor(uv.y * 40.0), floor(TIME * 8.0)));
		if (glitch > 0.9) {
			uv.x += (random(vec2(TIME, uv.y)) - 0.5) * 0.05; // desloca linhas horizontais
		}
	}
	vec4 tex = texture(TEXTURE, uv);
	float gray = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
	vec3 color = vec3(gray);
	if (infected) {
		float noise = random(uv * TIME * 0.001) * 0.15;
		color += noise;
		color.r += 0.1;
		}
	COLOR = vec4(color, tex.a);
}
