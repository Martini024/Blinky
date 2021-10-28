//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 100
        
        addCubeCollection()
    }
    
    var cubeCollection: CubeCollection!
    func addCubeCollection() {
        let count = 20
        cubeCollection = CubeCollection(cubesWide: count, cubesHigh: count, cubesBack: count)
        addChild(cubeCollection)
    }
    
    override func update(deltaTime: Float) {
        cubeCollection.rotation.z += deltaTime
        super.update(deltaTime: deltaTime)
    }
}
