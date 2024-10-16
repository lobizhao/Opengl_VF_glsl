#version 330 core

uniform sampler2D u_Texture; // An object that lets us access
                             // the texture file we project onto
                             // our model's surface
uniform vec3 u_CamLook; // the camera's forward vector
uniform ivec2 u_Dimensions;

in vec3 fs_Nor;
in vec2 fs_UV;
in vec3 fs_Pos;

out vec4 out_Color;


void main()
{

    float y_min = -1.0;
    float y_max = 1.0;
    float normalizedY = (fs_Pos.x - y_min) / (y_max - y_min);

    // Obtaining the material's base color from
    // the texture file
    vec3 albedo = texture(u_Texture, fs_UV).rgb*1.2;
    float gray = dot(albedo, vec3(0.2126, 0.7152, 0.0722));
    vec4 grayColor = vec4(vec3(gray), 1.0);



    // Lambertian term computed using the camera's
    // forward vector as the light direction
    albedo *= dot(-u_CamLook, fs_Nor);
    //out_Color = vec4(albedo, 1.);
    out_Color = vec4(vec3(gray), 1.0);

    out_Color = mix(grayColor, vec4(albedo, 1.0), clamp(normalizedY, 0.0, 1.0));
    //out_Color = mix(out_Color, albedo, fs_Pos.y);
}
