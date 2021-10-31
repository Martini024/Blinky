//
//  Quad.swift
//  Game Engine
//
//  Created by Martini Reinherz on 29/10/21.
//

import MetalKit

class Quandrangle: GameObject {
    init() {
        super.init(meshType: .quadrangle)
        self.setName("Quadrangle")
    }
}
