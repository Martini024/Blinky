//
//  MyShaders.metal
//  GameEngine
//
//  Created by Martini Reinherz on 12/10/21.
//

#include <metal_stdlib>
#include "Shared.metal"
#include "Lighting.metal"
using namespace metal;

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.color = vIn.color;
    rd.textureCoordinate = vIn.textureCoordinate;
    rd.totalGameTime = sceneConstants.totalGameTime;
    rd.worldPosition = worldPosition.xyz;
    rd.surfaceNormal = (modelConstants.modelMatrix * float4(vIn.normal, 0.0)).xyz;
    rd.toCameraVector = sceneConstants.cameraPosition - worldPosition.xyz;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     constant int &lightCount [[ buffer(2) ]],
                                     constant LightData *lightDatas [[ buffer(3) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> texture [[ texture(0)]]) {
    float2 textureCoordinate = rd.textureCoordinate;
    float4 color;
    
    if (material.useMaterialColor) {
        color = material.color;
    } else if (material.useTexture) {
        color = texture.sample(sampler2d, textureCoordinate);
    } else {
        color = rd.color;
    }
    
    if (material.isLit) {
        float3 unitNormal = normalize(rd.surfaceNormal);
        float3 unitToCameraVector = normalize(rd.toCameraVector);
        
        float3 phongIntensity = Lighting::GetPhongIntensity(material, lightDatas, lightCount,
                                                            rd.worldPosition, unitNormal, unitToCameraVector);
        color *= float4(phongIntensity, 1.0);
    }
    
    return half4(color.r, color.g, color.b, color.a);
}
