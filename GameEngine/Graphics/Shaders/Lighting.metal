//
//  Lighting.metal
//  Game Engine
//
//  Created by Martini Reinherz on 3/8/24.
//
#ifndef LIGHTING_METAL
#define LIGHTING_METAL

#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

class Lighting {
public:
    static float3 GetPhongIntensity(constant Material &material,
                                    constant LightData *lightDatas,
                                    int lightCount,
                                    float3 worldPosition,
                                    float3 unitNormal,
                                    float3 unitToCameraVector) {
        float3 totalAmbient = float3(0,0,0);
        float3 totalDiffuse = float3(0,0,0);
        float3 totalSpecular = float3(0,0,0);
        for(int i = 0; i < lightCount; i++){
            LightData lightData = lightDatas[i];
            
            float3 unitToLightVector = normalize(lightData.position - worldPosition);
            float3 unitReflectionVector = normalize(reflect(-unitToLightVector, unitNormal));
            
            // Ambient Lighting
            float3 ambientness = material.ambient * lightData.ambientIntensity;
            float3 ambientColor = clamp(ambientness * lightData.color * lightData.brightness, 0.0, 1.0);
            totalAmbient += ambientColor;
            
            // Diffuse Lighting
            float3 diffuseness = material.diffuse * lightData.diffuseIntensity;
            float nDotL = max(dot(unitNormal, unitToLightVector), 0.0); // N  dot  L
            float3 diffuseColor = clamp(diffuseness * nDotL * lightData.color * lightData.brightness, 0.0, 1.0);
            totalDiffuse += diffuseColor;
            
            // Specular Lighting
            float3 specularness = material.specular * lightData.specularIntensity;
            float rDotV = max(dot(unitReflectionVector, unitToCameraVector) ,0.0);
            float specularExp = pow(rDotV, material.shininess);
            float3 specularColor = clamp(specularness * specularExp * lightData.color * lightData.brightness, 0.0, 1.0);
            totalSpecular += specularColor;
            
        }
        return totalAmbient + totalDiffuse + totalSpecular;
    }
};

#endif
