#version 330 core

uniform ivec2 u_Dimensions;
uniform float u_Time;

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_Texture;

vec2 random2(vec2 p) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))));
}


float worleyNoise(vec2 uv) {

    uv *= 70.0;
    vec2 uvFlo = floor(uv);
    vec2 uvFra = fract(uv);

    float minDist = 1.0;
    for (int y = -1; y <= 1; ++y) {
        for (int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y));
            vec2 point = random2(uvFlo + neighbor);
            vec2 diff = neighbor + point - uvFra;
            float dist = length(diff);
            minDist = min(minDist, dist);
        }
    }

    return minDist;
}

void main() {

       float noise = worleyNoise(fs_UV);
       color = texture(u_Texture, vec2(fs_UV.x+noise* 0.03,fs_UV.y + noise*0.03)).rgb;

}
