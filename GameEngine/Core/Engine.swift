//
//  Engine.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import Metal

class Engine {
    public static var device: MTLDevice!
    public static var commandQueue: MTLCommandQueue!
    public static var defaultLibrary: MTLLibrary!
    
    public static func initialize(device: MTLDevice) {
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        self.defaultLibrary = device.makeDefaultLibrary()
        
        Graphics.initialize()
        
        DepthStencilStateLibrary.initialize()
        RenderPipelineDescriptorLibrary.initialize()
        RenderPipelineStateLibrary.initialize()
        
        Entities.initialize()
        
        SceneManager.initialize(Preferences.startingSceneType)
    }
}
