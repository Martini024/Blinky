//
//  RenderPipelineState.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum RenderPipelineStateType {
    case basic
    case instanced
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateType, MTLRenderPipelineState> {
    private var _library: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(RenderPipelineState(.basic), forKey: .basic)
        _library.updateValue(RenderPipelineState(.instanced), forKey: .instanced)
    }
    
    override subscript(type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return _library[type]!.renderPipelineState
    }
}

class RenderPipelineState {
    var renderPipelineState: MTLRenderPipelineState!
    init(_ renderPipelineDescriptorType: RenderPipelineDescriptorType) {
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: Graphics.renderPipelineDescriptors[.basic])
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__::\(error)")
        }
    }
}
