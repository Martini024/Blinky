//
//  DebugCamera.swift
//  Game Engine
//
//  Created by Martini Reinherz on 26/10/21.
//

import MetalKit

class DebugCamera: Camera {
    var cameraType: CameraType = .debug
    var position: simd_float3 = simd_float3(repeating: 0)
    var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45, aspectRatio: Renderer.aspectRatio, near: 0.1, far: 1000)
    }
    
    func update(deltaTime: Float) {
        if (Keyboard.isKeyPressed(.leftArrow)) {
            self.position.x += deltaTime
        }
        
        if (Keyboard.isKeyPressed(.rightArrow)) {
            self.position.x -= deltaTime
        }
        
        if (Keyboard.isKeyPressed(.upArrow)) {
            self.position.y -= deltaTime
        }
        
        if (Keyboard.isKeyPressed(.downArrow)) {
            self.position.y += deltaTime
        }
    }
}
