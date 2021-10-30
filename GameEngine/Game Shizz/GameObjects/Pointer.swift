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
    
    override func doUpdate() {
        self.rotateZ(-atan2f(
            Mouse.getMouseViewportPosition().x - getPositionX() + camera.getPositionX(),
            Mouse.getMouseViewportPosition().y - getPositionY() + camera.getPositionY()))
    }
}
