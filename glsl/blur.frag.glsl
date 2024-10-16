#version 330 core

in vec2 fs_UV;
out vec3 color;

uniform sampler2D u_Texture;
//add screen
uniform ivec2 u_Dimensions;

float kernel[121] = float[](0.006849, 0.007239, 0.007559, 0.007795, 0.007941, 0.00799, 0.007941, 0.007795, 0.007559, 0.007239, 0.006849,
                            0.007239, 0.007653, 0.00799, 0.00824, 0.008394, 0.008446, 0.008394, 0.00824, 0.00799, 0.007653, 0.007239,
                            0.007559, 0.00799, 0.008342, 0.008604, 0.008764, 0.008819, 0.008764, 0.008604, 0.008342, 0.00799, 0.007559,
                            0.007795, 0.00824, 0.008604, 0.008873, 0.009039, 0.009095, 0.009039, 0.008873, 0.008604, 0.00824, 0.007795,
                            0.007941, 0.008394, 0.008764, 0.009039, 0.009208, 0.009265, 0.009208, 0.009039, 0.008764, 0.008394, 0.007941,
                            0.00799, 0.008446, 0.008819, 0.009095, 0.009265, 0.009322, 0.009265, 0.009095, 0.008819, 0.008446, 0.00799,
                            0.007941, 0.008394, 0.008764, 0.009039, 0.009208, 0.009265, 0.009208, 0.009039, 0.008764, 0.008394, 0.007941,
                            0.007795, 0.00824, 0.008604, 0.008873, 0.009039, 0.009095, 0.009039, 0.008873, 0.008604, 0.00824, 0.007795,
                            0.007559, 0.00799, 0.008342, 0.008604, 0.008764, 0.008819, 0.008764, 0.008604, 0.008342, 0.00799, 0.007559,
                            0.007239, 0.007653, 0.00799, 0.00824, 0.008394, 0.008446, 0.008394, 0.00824, 0.00799, 0.007653, 0.007239,
                            0.006849, 0.007239, 0.007559, 0.007795, 0.007941, 0.00799, 0.007941, 0.007795, 0.007559, 0.007239, 0.006849);

const int radius = 5;
const int dim = 11;

void main()
{

    vec2 texelSize = 1.0 / vec2(u_Dimensions);


    vec3 finalColor = vec3(0.0);
    float weightSum = 0.0;

    for (int i = -radius; i <= radius; i++) {
        for (int j = -radius; j <= radius; j++) {
            vec2 offset = vec2(float(i), float(j)) * texelSize;
            vec2 sampleUV = fs_UV + offset;

            int kernelIndex = (i + radius) * dim + (j + radius);
            float kernelValue = kernel[kernelIndex];

            vec3 sampleColor = texture(u_Texture, sampleUV).rgb;

            finalColor += sampleColor * kernelValue;
            weightSum += kernelValue;
        }
    }

    finalColor /= weightSum;

    color = finalColor;
    // TODO: Compute the weighted average of the 11x11 set of pixels
    // in u_Texture surrounding the current fragment's location.
    // The weights are stored in the array above; index into it
    // using the same method you used to index into the Z buffer
    // in homework 3.
    //color = texture(u_Texture, fs_UV).rgb;
}
