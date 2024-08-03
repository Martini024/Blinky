//
//  SamplerStateLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

import MetalKit

enum SamplerStateType {
    case none
    case linear
}

class SamplerStateLibrary: Library<SamplerStateType, MTLSamplerState> {
    private var library: [SamplerStateType : SamplerState] = [:]
    
    override func fillLibrary() {
        library.updateValue(Linear_SamplerState(), forKey: .linear)
    }
    
    override subscript(_ type: SamplerStateType) -> MTLSamplerState {
        return (library[type]?.samplerState!)!
    }
}

protocol SamplerState {
    var name: String { get }
    var samplerState: MTLSamplerState! { get }
}

class Linear_SamplerState: SamplerState {
    var name: String = "Linear Sampler State"
    var samplerState: MTLSamplerState!
    
    init() {
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        samplerDescriptor.mipFilter = .linear
        samplerDescriptor.label = name
        samplerState = Engine.device.makeSamplerState(descriptor: samplerDescriptor)
    }
}
