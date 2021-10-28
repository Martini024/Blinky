//
//  MeshLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum MeshType {
    case triangle
    case quadrangle
    case cube
}

class MeshLibrary {
    private static var meshes: [MeshType: Mesh] = [:]
    
    public static func initialze() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(TriangleMesh(), forKey: .triangle)
        meshes.updateValue(QuadrangleMesh(), forKey: .quadrangle)
        meshes.updateValue(CubeMesh(), forKey: .cube)
    }
    
    public static func mesh(_ meshType: MeshType) -> Mesh {
        return meshes[meshType]!
    }
}

protocol MeshProtocol {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
    func setInstacneCount(_ count: Int)
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

class Mesh: MeshProtocol {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    var instanceCount: Int = 1
    var vertexCount: Int! {
        return vertices.count
    }
    
    init() {
        createVertices()
        createBuffers()
    }
    
    func createVertices() { }
    
    private func createBuffers() {
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    func setInstacneCount(_ count: Int) {
        self.instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount, instanceCount: instanceCount)
    }
}

class TriangleMesh: Mesh {
    override func createVertices() {
        vertices = [
            Vertex(position: simd_float3( 0, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,1,0,1)),
            Vertex(position: simd_float3( 1,-1, 0), color: simd_float4(0,0,1,1))
        ]
    }
}

class QuadrangleMesh: Mesh {
    override func createVertices() {
        vertices = [
            Vertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1, 1, 0), color: simd_float4(0,1,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1)),
            
            Vertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1)),
            Vertex(position: simd_float3( 1,-1, 0), color: simd_float4(1,0,1,1))
        ]
    }
}

class CubeMesh: Mesh {
    override func createVertices() {
        vertices = [
            //Left
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.5, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0)),
            
            //RIGHT
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.5, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0)),
            
            //TOP
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.5, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0)),
            
            //BOTTOM
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0)),
            
            //BACK
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0)),
            
            //FRONT
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(0.5, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
        ]
    }
}
