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

class RenderPipelineStateLibrary {
    private static var renderPipelineStates: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    public static func initialize() {
        createDefaultRenderPipelineState()
    }
    
    private static func createDefaultRenderPipelineState() { 
        renderPipelineStates.updateValue(BasicRenderPipelineState(), forKey: .basic)
        renderPipelineStates.updateValue(InstancedRenderPipelineState(), forKey: .instanced)
    }
    
    public static func pipelineState(_ renderPipelineStateType: RenderPipelineStateType) -> MTLRenderPipelineState {
        return renderPipelineStates[renderPipelineStateType]!.renderPipelineState
    }
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

public struct BasicRenderPipelineState: RenderPipelineState {
    var name: String = "Basic Vertext Descriptor"
    var renderPipelineState: MTLRenderPipelineState!
    init() {
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.descriptor(.basic))
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__\(name)__::\(error)")
        }
    }
}

public struct InstancedRenderPipelineState: RenderPipelineState {
    var name: String = "Instanced Vertext Descriptor"
    var renderPipelineState: MTLRenderPipelineState!
    init() {
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.descriptor(.instanced))
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__\(name)__::\(error)")
        }
    }
}
