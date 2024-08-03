//
//  Sun.swift
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

import MetalKit

class Sun: LightObject {
    init() {
        super.init(name: "Sun", meshType: .sphere)
        self.setMaterialColor(float4(1, 0, 0, 1.0))
        self.setScale(0.3)
    }
}

