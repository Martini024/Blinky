//
//  DebugCamera.swift
//  Game Engine
//
//  Created by Martini Reinherz on 26/10/21.
//

import MetalKit

class DebugCamera: Camera {
    
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45, aspectRatio: Renderer.aspectRatio, near: 0.1, far: 1000)
    }
    
    init() {
        super.init(cameraType: .debug)
    }
    
    override func doUpdate() {
        if (Keyboard.isKeyPressed(.leftArrow)) {
            self.moveX(GameTime.deltaTime)
        }
        
        if (Keyboard.isKeyPressed(.rightArrow)) {
            self.moveX(-GameTime.deltaTime)
        }
        
        if (Keyboard.isKeyPressed(.upArrow)) {
            self.moveY(-GameTime.deltaTime)
        }
        
        if (Keyboard.isKeyPressed(.downArrow)) {
            self.moveY(GameTime.deltaTime)
        }
    }
}
