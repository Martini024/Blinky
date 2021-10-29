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

class MeshLibrary: Library<MeshType, Mesh> {
    private var _library: [MeshType: Mesh] = [:]
    
    override func fillLibrary() {
        _library.updateValue(TriangleMesh(), forKey: .triangle)
        _library.updateValue(QuadrangleMesh(), forKey: .quadrangle)
        _library.updateValue(CubeMesh(), forKey: .cube)
    }
    
    override subscript(type: MeshType) -> Mesh? {
        return _library[type]!
    }
}

protocol MeshProtocol {
    var vertexCount: Int! { get }
    func setInstacneCount(_ count: Int)
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

class Mesh: MeshProtocol {
    private var _vertices: [Vertex] = []
    private var _vertexBuffer: MTLBuffer!
    private var _instanceCount: Int = 1
    var vertexCount: Int! {
        return _vertices.count
    }
    
    init() {
        createVertices()
        createBuffers()
    }
    
    func createVertices() { }
    
    private func createBuffers() {
        _vertexBuffer = Engine.device.makeBuffer(bytes: _vertices, length: Vertex.stride(vertexCount), options: [])
    }
    
    func addVertex(position: simd_float3, color: simd_float4 = simd_float4(1, 0, 1, 1)) {
        _vertices.append(Vertex(position: position, color: color))
    }
    
    func setInstacneCount(_ count: Int) {
        self._instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount, instanceCount: _instanceCount)
    }
}

class TriangleMesh: Mesh {
    override func createVertices() {
        addVertex(position: simd_float3( 0, 1, 0), color: simd_float4(1,0,0,1))
        addVertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,1,0,1))
        addVertex(position: simd_float3( 1,-1, 0), color: simd_float4(0,0,1,1))
    }
}

class QuadrangleMesh: Mesh {
    override func createVertices() {
        addVertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1))
        addVertex(position: simd_float3(-1, 1, 0), color: simd_float4(0,1,0,1))
        addVertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1))
        
        addVertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1))
        addVertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1))
        addVertex(position: simd_float3( 1,-1, 0), color: simd_float4(1,0,1,1))
    }
}

class CubeMesh: Mesh {
    override func createVertices() {
        //Left
        addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.5, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
        
        //RIGHT
        addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.5, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
        
        //TOP
        addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.0, 1.0))
        addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.5, 1.0, 1.0, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
        
        //BOTTOM
        addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
        
        //BACK
        addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
        
        //FRONT
        addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(0.5, 0.0, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
    }
}
