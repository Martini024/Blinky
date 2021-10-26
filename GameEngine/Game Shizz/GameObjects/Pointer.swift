//
//  Pointer.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import Foundation

class Pointer: GameObject {
    
    private var camera: Camera!
    
    init(camera: Camera) {
        super.init(meshType: .triangle)
        self.camera = camera
    }
    
    override func update(deltaTime: Float) {
        self.rotation.z = -atan2f(
            Mouse.getMouseViewportPosition().x - position.x + camera.position.x,
            Mouse.getMouseViewportPosition().y - position.y + camera.position.y)
        super.update(deltaTime: deltaTime)
    }
}
