#version 330 core
uniform mat4 u_MVP; // Model-View-Projection matrix
uniform mat4 u_View;
uniform mat4 u_Proj;
//
uniform mat3 u_ViewMatrix;
uniform vec3 u_CamPos; // The camera's position

in vec3 vs_Pos;
in vec3 vs_Nor;

out vec2 fs_UV;

void main()
{
    // TODO: Map your surface normal to camera space,
    // then map the camera-space normal to UV coordinates
    // for sampling the matcap texture in the fragment shader

    vec3 viewSpaceNormal = normalize(u_ViewMatrix * vs_Nor);
    //vec3 viewDir = normalize(u_CamPos - vs_Pos);

    fs_UV = viewSpaceNormal.xy *0.5 + 0.5;
    //transform to clipSpace
    gl_Position = u_Proj * u_View * vec4(vs_Pos, 1.);


}
