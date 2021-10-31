//
//  Cruiser.swift
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

import MetalKit

class Cruiser: GameObject {
    init() {
        super.init(meshType: .cruiser)
        setName("Cruiser")
        setTexture(.cruiser)
    }
}
