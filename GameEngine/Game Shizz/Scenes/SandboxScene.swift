//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//
class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var chest = Chest()
    var sun = Sun()
    
    override func buildScene() {
        debugCamera.setPositionZ(3)
        addCamera(debugCamera)
        
        sun.setPosition(0, 5, 5)
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        chest.moveY(-0.5)
        addChild(chest)
    }
    
    override func doUpdate() {
        if (Mouse.isMouseButtonPressed(button: .left)) {
            chest.rotateX(Mouse.getDY() * GameTime.deltaTime)
            chest.rotateY(Mouse.getDX() * GameTime.deltaTime)
        }
        
    }
}
