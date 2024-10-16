#version 330 core

in vec2 fs_UV;
out vec3 color;

uniform sampler2D u_Texture;
// texture scale
uniform ivec2 u_Dimensions;

float horizontal[9] = float[9](3, 0, -3, 10, 0, -10, 3, 0, -3);
float vertical[9] = float[9](3, 10, 3, 0, 0, 0, -3, -10, -3);

void main() {
    vec3 grad_h = vec3(0);
    vec3 grad_v = vec3(0);

    for (int i = 0; i < 9; i++) {

        float x = float(i % 3); // Cast x to float
        float y = float(i / 3); // Cast y to float directly without using floor

        float pixels_x = fs_UV[0] + ((x - 1.0) / float(u_Dimensions[0]));
        float pixels_y = fs_UV[1] + ((y - 1.0) / float(u_Dimensions[1]));

        grad_h += horizontal[i] * vec3(texture(u_Texture, vec2(pixels_x, pixels_y)));
        grad_v += vertical[i] * vec3(texture(u_Texture, vec2(pixels_x, pixels_y)));
    }

    color = vec3(
        pow(grad_h[0] * grad_h[0] + grad_v[0] * grad_v[0], 0.5),
        pow(grad_h[1] * grad_h[1] + grad_v[1] * grad_v[1], 0.5),
        pow(grad_h[2] * grad_h[2] + grad_v[2] * grad_v[2], 0.5)
    );
}
