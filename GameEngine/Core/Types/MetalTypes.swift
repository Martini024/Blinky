//
//  Types.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import simd

public typealias float2 = SIMD2<Float>
public typealias float3 = SIMD3<Float>
public typealias float4 = SIMD4<Float>

protocol Sizable {
    static func size(_ count: Int) -> Int
    static func stride(_ count: Int) -> Int
}

extension Sizable {
    static var size: Int {
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int = 1) -> Int {
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int = 1) -> Int {
        return MemoryLayout<Self>.stride * count
    }
}

struct Vertex: Sizable {
    var position: float3
    var color: float4
    var textureCoordinate: float2
    var normal: float3;
}

extension Int32: Sizable { }
extension float2: Sizable { }
extension float3: Sizable { }
extension float4: Sizable { }
extension Float: Sizable { }

struct ModelConstants: Sizable {
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants: Sizable {
    var totalGameTime: Float = 0
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    var cameraPosition = float3(0, 0, 0)
}

struct Material: Sizable {
    var color = float4(0.8, 0.8, 0.8, 1.0)
    var useMaterialColor: Bool = false
    var useTexture: Bool = false
    var isLit: Bool = true
    
    var ambient: float3 = float3(0.03, 0.03, 0.03)
    var diffuse: float3 = float3(1, 1, 1)
    var specular: float3 = float3(1, 1, 1)
    var shininess: Float = 2
}

struct LightData: Sizable {
    var position: float3 = float3(0, 0, 0)
    var color: float3 = float3(1, 1, 1)
    var brightness: Float = 1.0
    
    var ambientIntensity: Float = 1.0
    var diffuseIntensity: Float = 1.0
    var specularIntensity: Float = 1.0
}
