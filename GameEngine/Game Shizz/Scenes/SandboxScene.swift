//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//
class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var quad = Quad()
    var sun = Sun()
    
    override func buildScene() {
        debugCamera.setPositionZ(3)
        addCamera(debugCamera)
        
        sun.setPosition(0, 5, 5)
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        quad.useBaseColorTexture(.metalPlateDiffuse)
        quad.useNormalMapTexture(.metalPlateNormal)
        addChild(quad)
    }
    
    override func doUpdate() {
        if (Mouse.isMouseButtonPressed(button: .left)) {
            quad.rotateX(Mouse.getDY() * GameTime.deltaTime)
            quad.rotateY(Mouse.getDX() * GameTime.deltaTime)
        }
        
    }
}
