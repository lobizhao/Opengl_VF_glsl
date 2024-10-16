#version 330 core

uniform mat4 u_View;
uniform mat4 u_Proj;

uniform float u_Time;
uniform mat3 u_ViewMatrix;

in vec3 vs_Pos;
in vec3 vs_Nor;
in vec2 vs_UV;

out vec3 fs_Pos;
out vec3 fs_Nor;
out vec2 fs_UV;

void main()
{

    fs_Nor = normalize(u_ViewMatrix * vs_Nor);

    vec3 transformed = vs_Pos;
    transformed.x += sin(vs_Pos.y * 2.0 + u_Time * 0.3) * 0.2;

    fs_Pos = vec3(u_View * vec4(transformed, 1.0));

    gl_Position = u_Proj * u_View * vec4(transformed, 1.);
}
