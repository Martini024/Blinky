//
//  LightObject.swift
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

import MetalKit

class LightObject: GameObject {
    
    var lightData = LightData()
    
    init(name: String) {
        super.init(meshType: .none)
        self.setName(name)
    }
    
    init(meshType: MeshType, name: String) {
        super.init(meshType: meshType)
        self.setName(name)
    }
    
    override func update() {
        self.lightData.position = self.getPosition()
        super.update()
    }
}
