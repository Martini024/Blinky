//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var quadrangle = Quandrangle()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 5
        
        addChild(quadrangle)
    }
    
    override func doUpdate() {
        quadrangle.position.x = cos(GameTime.totalGameTime)
    }
}
