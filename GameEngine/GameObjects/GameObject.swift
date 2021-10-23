//
//  GameObject.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class GameObject {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    
    init() {
        createVertices()
        createBuffers()
    }
    
    private func createVertices() {
        vertices = [
            Vertex(position: simd_float3( 0, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,1,0,1)),
            Vertex(position: simd_float3( 1,-1, 0), color: simd_float4(0,0,1,1))
        ]
    }
    
    private func createBuffers() {
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.basic))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}
