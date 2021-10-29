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

class RenderPipelineDescriptorLibrary {
    private static var renderPipelineDescriptors: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    public static func initialize() {
        createDefaultRenderPipelineDescriptor()
    }
    
    private static func createDefaultRenderPipelineDescriptor() {
        renderPipelineDescriptors.updateValue(BasicRenderPipelineDescriptor(), forKey: .basic)
        renderPipelineDescriptors.updateValue(InstancedRenderPipelineDescriptor(), forKey: .instanced)
    }
    
    public static func descriptor(_ renderPipelineDescriptorType: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptors[renderPipelineDescriptorType]!.renderPipelineDescriptor
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
