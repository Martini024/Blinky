//
//  RenderPipelineDescriptorLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum RenderPipelineDescriptorType {
    case basic
}

class RenderPipelineDescriptorLibrary {
    private static var renderPipelineDescriptors: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    public static func initialize() {
        createDefaultRenderPipelineDescriptor()
    }
    
    private static func createDefaultRenderPipelineDescriptor() {
        renderPipelineDescriptors.updateValue(BasicRenderPipelineDescriptor(), forKey: .basic)
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
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.vertex(.basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.fragment(.basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.descriptor(.basic)
    }
}
