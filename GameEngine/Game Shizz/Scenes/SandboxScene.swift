//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var cruiser = Cruiser()
    var leftSun = Sun()
    var middleSun = Sun()
    var rightSun = Sun()
    
    override func buildScene() {
        debugCamera.setPositionZ(6)
        addCamera(debugCamera)
        
        leftSun.setPosition(float3(-1, 1, 0))
        leftSun.setMaterialIsLit(false)
        leftSun.setMaterialColor(float4(1, 0, 0, 1))
        leftSun.setLightColor(float3(1, 0, 0))
        addLight(leftSun)
        
        middleSun.setPosition(float3(0, 1, 0))
        middleSun.setLightBrightness(0.33)
        middleSun.setMaterialIsLit(false)
        middleSun.setMaterialColor(float4(1, 1, 1, 1))
        middleSun.setLightColor(float3(1, 1, 1))
        addLight(middleSun)
        
        rightSun.setPosition(float3(1, 1, 0))
        rightSun.setMaterialIsLit(false)
        rightSun.setMaterialColor(float4(0, 0, 1, 1))
        rightSun.setLightColor(float3(0, 0, 1))
        addLight(rightSun)
        
        cruiser.setMaterialAmbient(0.01)
        addChild(cruiser)
    }
    
    override func doUpdate() {
        if (Mouse.isMouseButtonPressed(button: .left)) {
            cruiser.rotateX(Mouse.getDY() * GameTime.deltaTime)
            cruiser.rotateY(Mouse.getDX() * GameTime.deltaTime)
        }
        
        leftSun.setPositionX(cos(GameTime.totalGameTime) - 1)
        middleSun.setPositionX(cos(GameTime.totalGameTime))
        rightSun.setPositionX(cos(GameTime.totalGameTime) + 1)
        
        cruiser.setMaterialShininess(cruiser.getMaterialShininess() + Mouse.getDWheel())
    }
}
