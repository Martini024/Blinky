//
//  Cube.swift
//  Game Engine
//
//  Created by Martini Reinherz on 27/10/21.
//

import MetalKit

class Cube: GameObject {
    init() {
        super.init(meshType: .cube)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.x += (Float.random(in: 0...1) * deltaTime)
        self.rotation.y += (Float.random(in: 0...1) * deltaTime)
        super.update(deltaTime: deltaTime)
    }
}
