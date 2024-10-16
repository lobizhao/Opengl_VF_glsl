#version 330 core

uniform sampler2D u_Texture; // An object that lets us access
                             // the texture file we project onto
                             // our model's surface
uniform vec3 u_CamLook; // The camera's forward vector
uniform vec3 u_CamPos; // The camera's position

//add light infor
uniform vec3 u_ViewPos;
uniform vec3 u_LightPos;
uniform vec3 u_LightCol;
uniform float u_Shininess;

//add ambient color
uniform vec3 u_AmbientCol;


in vec3 fs_Pos;
in vec3 fs_Nor;
in vec2 fs_UV;

out vec3 out_Color;

void main()
{

    vec3 norm = normalize(fs_Nor);
    vec3 lightDir = normalize(u_CamPos - fs_Pos);
    vec3 viewDir = normalize(u_CamPos - fs_Pos);

    vec3 ambient = u_AmbientCol * texture(u_Texture, fs_UV).rgb;

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = u_LightCol * diff * texture(u_Texture, fs_UV).rgb;

    vec3 halfwayDir = normalize(lightDir + viewDir);
    float spec = pow(max(dot(norm, halfwayDir), 0.0), u_Shininess);
    vec3 specular = u_LightCol * spec;

    //combined ambient diffuse and specular
    out_Color = ambient + diffuse + specular;

    // TODO: Implement Blinn-Phong reflection
    //out_Color = texture(u_Texture, fs_UV).rgb;

}
