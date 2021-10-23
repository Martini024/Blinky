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
}

class MeshLibrary {
    private static var meshes: [MeshType: Mesh] = [:]
    
    public static func initialze() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(TriangleMesh(), forKey: .triangle)
        meshes.updateValue(QuadrangleMesh(), forKey: .quadrangle)
    }
    
    public static func mesh(_ meshType: MeshType) -> Mesh {
        return meshes[meshType]!
    }
}

protocol MeshProtocol {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}

class Mesh: MeshProtocol {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
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
