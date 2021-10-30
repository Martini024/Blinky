//
//  Shared.metal
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
};

struct SceneConstants {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct Material {
    float4 color;
    bool useMaterialColor;
};
