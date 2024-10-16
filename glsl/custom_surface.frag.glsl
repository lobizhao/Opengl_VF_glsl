#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform float u_Time;
uniform vec3 u_CamPos;

in vec3 fs_Pos;
in vec3 fs_Nor;
in vec2 fs_UV;

layout(location = 0) out vec3 out_Color;

void main()
{
    vec3 normal = normalize(fs_Nor);
    vec3 viewDir = normalize(-fs_Pos);

    float fresnel = dot(normal , viewDir);
    vec2 uv = vec2(fresnel, fresnel)+ vec2(u_Time * 0.01);
    uv = mod(uv, 1.0);
    vec3 iridescentColor  = texture(u_Texture, uv).rgb;

    //out_Color = texture(u_Texture, fs_UV).rgb;
    out_Color = iridescentColor;
}
