//
//  DepthStencilStateLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 27/10/21.
//

import MetalKit

enum DepthStencilStateType {
    case less
}

class DepthStencilStateLibrary {
    
    private static var _depthStencilStates: [DepthStencilStateType: DepthStencilState] = [:]
    
    public static func initialize() {
        createDefaultDepthStencilStates()
    }
    
    private static func createDefaultDepthStencilStates() {
        _depthStencilStates.updateValue(LessDepthStencilState(), forKey: .less)
    }
    
    public static func depthStencilState(_ depthStencilStateType: DepthStencilStateType) -> MTLDepthStencilState {
        return _depthStencilStates[depthStencilStateType]!.depthStencilState
    }
}

protocol DepthStencilState {
    var depthStencilState: MTLDepthStencilState! { get }
}

class LessDepthStencilState: DepthStencilState {
    
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = Engine.device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
}
