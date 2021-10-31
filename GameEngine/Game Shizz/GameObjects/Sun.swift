//
//  Sun.swift
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

import MetalKit

class Sun: LightObject {
    init() {
        super.init(meshType: .sphere, name: "Sun")
        self.setColor(simd_float4(0.5, 0.5, 0, 1.0))
        self.setScale(0.3)
    }
}

