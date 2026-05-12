shader_type spatial;

uniform vec4 color_a : source_color = vec4(0.4, 0.4, 0.4, 1.0);
uniform vec4 color_b : source_color = vec4(0.65, 0.65, 0.65, 1.0);
uniform float tile_size : hint_range(0.5, 10.0) = 2.0;

void fragment() {
    vec2 uv = floor(UV * (50.0 / tile_size));
    float checker = mod(uv.x + uv.y, 2.0);
    ALBEDO = mix(color_a, color_b, checker).rgb;
    ROUGHNESS = 0.9;
}