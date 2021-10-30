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
        let cube = Cube()
        cube.setScale(simd_float3(repeating: 0.3))
        addChild(cube)
    }
}
