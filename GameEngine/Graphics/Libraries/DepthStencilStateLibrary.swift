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

class DepthStencilStateLibrary: Library<DepthStencilStateType, MTLDepthStencilState> {
    private var _library: [DepthStencilStateType: DepthStencilState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(LessDepthStencilState(), forKey: .less)
    }
    
    override subscript(type: DepthStencilStateType) -> MTLDepthStencilState {
        return _library[type]!.depthStencilState
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
