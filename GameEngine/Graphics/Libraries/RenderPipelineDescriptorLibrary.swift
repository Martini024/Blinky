//
//  RenderPipelineDescriptorLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum RenderPipelineDescriptorType {
    case basic
    case instanced
}

class RenderPipelineDescriptorLibrary: Library<RenderPipelineDescriptorType, MTLRenderPipelineDescriptor> {
    private var _library: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    
    override func fillLibrary() {
        _library.updateValue(BasicRenderPipelineDescriptor(), forKey: .basic)
        _library.updateValue(InstancedRenderPipelineDescriptor(), forKey: .instanced)
    }
    
    override subscript(type: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor {
        return _library[type]!.renderPipelineDescriptor
    }
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor! { get }
}

public struct BasicRenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Vertext Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.mainDepthPixelFormat
        renderPipelineDescriptor.vertexFunction = Graphics.vertexShaders[.basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.fragmentShaders[.basic]
        renderPipelineDescriptor.vertexDescriptor = Graphics.vertexDescriptors[.basic]
    }
}

public struct InstancedRenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Instanced Vertext Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.mainDepthPixelFormat
        renderPipelineDescriptor.vertexFunction = Graphics.vertexShaders[.instanced]
        renderPipelineDescriptor.fragmentFunction = Graphics.fragmentShaders[.basic]
        renderPipelineDescriptor.vertexDescriptor = Graphics.vertexDescriptors[.basic]
    }
}
