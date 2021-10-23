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
    
    public static func initialize(device: MTLDevice) {
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        ShaderLibrary.initialize()
        VertexDescriptorLibrary.initialize()
        RenderPipelineDescriptorLibrary.initialize()
        RenderPipelineStateLibrary.initialize()
        MeshLibrary.initialze()
    }
}
