//
//  Cube.swift
//  Game Engine
//
//  Created by Martini Reinherz on 27/10/21.
//

import MetalKit

class Cube: GameObject {
    init() {
        super.init(name: "Cube", meshType: .cube)
    }
    
    override func doUpdate() {
        self.rotateX(GameTime.deltaTime)
        self.rotateY(GameTime.deltaTime)
    }
}
