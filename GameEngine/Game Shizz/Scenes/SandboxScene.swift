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
        debugCamera.setPositionZ(6)
        addCamera(debugCamera)
        
        sun.setPosition(0, 2, 0)
        sun.setMaterialIsLit(false)
        sun.setLightBrightness(0.3)
        sun.setLightColor(1, 1, 1)
        addLight(sun)
        
        quad.setMaterialAmbient(0.01)
        quad.setMaterialShininess(10)
        quad.setMaterialSpecular(5)
        quad.setTexture(.partyPirateParot)
        addChild(quad)
    }
    
    override func doUpdate() {
        if (Mouse.isMouseButtonPressed(button: .left)) {
            quad.rotateX(Mouse.getDY() * GameTime.deltaTime)
            quad.rotateY(Mouse.getDX() * GameTime.deltaTime)
        }
        
    }
}
