//
//  Player.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import Foundation

class Player: GameObject {
    
    init() {
        super.init(meshType: .triangle)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.z = -atan2f(Mouse.getMouseViewportPosition().x - position.x, Mouse.getMouseViewportPosition().y - position.y)
        super.update(deltaTime: deltaTime)
    }
}
