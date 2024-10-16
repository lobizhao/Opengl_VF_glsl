#version 330 core

uniform float u_Time;
uniform sampler2D u_Texture;
in vec2 fs_UV;

out vec3 color;

vec2 random2(vec2 p) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

// Worley Noise
vec2 worleyCellCenter(vec2 uv) {
    uv *= 80.0;
    vec2 uvFlo = floor(uv);
    vec2 uvFra = fract(uv);

    vec2 cellCenter = vec2(0.0);
    float minDist = 1.0;

    for (int y = -1; y <= 1; ++y) {
        for (int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y));
            vec2 point = random2(uvFlo + neighbor);
            vec2 diff = neighbor + point - uvFra;
            float dist = length(diff);
            if (dist < minDist) {
                minDist = dist;
                cellCenter = neighbor + point;
            }
        }
    }

    return cellCenter + uvFlo;
}

void main() {

    vec2 cellCenter = worleyCellCenter(fs_UV);
    vec3 sampledColor = texture(u_Texture, cellCenter / 80.0).rgb;
    color = sampledColor;
}
