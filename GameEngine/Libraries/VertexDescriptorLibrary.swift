//
//  VertexDescriptorLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum VertexDescriptorType {
    case basic
}

class VertexDescriptorLibrary {
    private static var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    public static func initialize() {
        createDefaultVertexDescriptor()
    }
    
    private static func createDefaultVertexDescriptor() {
        vertexDescriptors.updateValue(BasicVertexDescriptor(), forKey: .basic)
    }
    
    public static func descriptor(_ vertexDescriptorType: VertexDescriptorType) -> MTLVertexDescriptor {
        return vertexDescriptors[vertexDescriptorType]!.vertexDescriptor
    }
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor! { get }
}

public struct BasicVertexDescriptor: VertexDescriptor {
    var name: String = "Basic Vertext Descriptor"
    var vertexDescriptor: MTLVertexDescriptor!
    
    init() {
        vertexDescriptor = MTLVertexDescriptor()
        
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = simd_float3.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
    }
}
