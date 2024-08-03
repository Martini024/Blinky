//
//  MeshLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum MeshType {
    case none
    
    case triangle
    case quad
    case cube
    
    case cruiser
    case sphere
}

class MeshLibrary: Library<MeshType, Mesh> {
    private var _library: [MeshType: Mesh] = [:]
    
    override func fillLibrary() {
        _library.updateValue(NoMesh(), forKey: .none)
        
        _library.updateValue(TriangleMesh(), forKey: .triangle)
        _library.updateValue(QuadMesh(), forKey: .quad)
        _library.updateValue(CubeMesh(), forKey: .cube)
        
        _library.updateValue(ModelMesh(modelName: "cruiser"), forKey: .cruiser)
        _library.updateValue(ModelMesh(modelName: "sphere"), forKey: .sphere)
    }
    
    override subscript(type: MeshType) -> Mesh {
        return _library[type]!
    }
}

protocol Mesh {
    func setInstacneCount(_ count: Int)
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

class NoMesh: Mesh {
    func setInstacneCount(_ count: Int) { }
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) { }
}

class CustomMesh: Mesh {
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
    
    func addVertex(position: float3,
                   color: float4 = float4(1, 0, 1, 1),
                   textureCoordinate: float2 = float2(repeating: 0),
                   normal: float3 = float3(0, 1, 0)) {
        _vertices.append(Vertex(position: position, color: color, textureCoordinate: textureCoordinate, normal: normal))
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

class ModelMesh: Mesh {
    private var _meshes: [Any]!
    private var _instanceCount: Int = 1
    
    init(modelName: String) {
        loadModel(modelName: modelName)
    }
    
    func loadModel(modelName: String, ext: String = "obj") {
        guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: ext) else {
            fatalError("Asset \(modelName) does not exist.")
        }
        
        let descriptor = MTKModelIOVertexDescriptorFromMetal(Graphics.vertexDescriptors[.basic])
        (descriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
        (descriptor.attributes[1] as! MDLVertexAttribute).name = MDLVertexAttributeColor
        (descriptor.attributes[2] as! MDLVertexAttribute).name = MDLVertexAttributeTextureCoordinate
        (descriptor.attributes[3] as! MDLVertexAttribute).name = MDLVertexAttributeNormal
        
        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.device)
        let asset: MDLAsset = MDLAsset(url: assetURL,
                                       vertexDescriptor: descriptor,
                                       bufferAllocator: bufferAllocator)
        do {
            self._meshes = try MTKMesh.newMeshes(asset: asset, device: Engine.device).metalKitMeshes
        } catch {
            print("ERROR::LOADING_MESH::__\(modelName)__::\(error)")
        }
    }
    
    func setInstacneCount(_ count: Int) {
        self._instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        guard let meshes = self._meshes as? [MTKMesh] else { return }
        for mesh in meshes {
            for vertexBuffer in mesh.vertexBuffers {
                renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
                for submesh in mesh.submeshes {
                    renderCommandEncoder.drawIndexedPrimitives(
                        type: submesh.primitiveType,
                        indexCount: submesh.indexCount,
                        indexType: submesh.indexType,
                        indexBuffer: submesh.indexBuffer.buffer,
                        indexBufferOffset: submesh.indexBuffer.offset,
                        instanceCount: self._instanceCount)
                }
            }
        }
    }
}

class TriangleMesh: CustomMesh {
    override func createVertices() {
        addVertex(position: float3( 0, 1, 0), color: float4(1,0,0,1))
        addVertex(position: float3(-1,-1, 0), color: float4(0,1,0,1))
        addVertex(position: float3( 1,-1, 0), color: float4(0,0,1,1))
    }
}

class QuadMesh: CustomMesh {
    override func createVertices() {
        addVertex(position: float3( 1, 1, 0), color: float4(1,0,0,1), textureCoordinate: float2(1, 0), normal: float3(0, 0, 1))
        addVertex(position: float3(-1, 1, 0), color: float4(0,1,0,1), textureCoordinate: float2(0, 0), normal: float3(0, 0, 1))
        addVertex(position: float3(-1,-1, 0), color: float4(0,0,1,1), textureCoordinate: float2(0, 1), normal: float3(0, 0, 1))

        addVertex(position: float3( 1, 1, 0), color: float4(1,0,0,1), textureCoordinate: float2(1, 0), normal: float3(0, 0, 1))
        addVertex(position: float3(-1,-1, 0), color: float4(0,0,1,1), textureCoordinate: float2(0, 1), normal: float3(0, 0, 1))
        addVertex(position: float3( 1,-1, 0), color: float4(1,0,1,1), textureCoordinate: float2(1, 1), normal: float3(0, 0, 1))
    }
}

class CubeMesh: CustomMesh {
    override func createVertices() {
        //Left
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(1.0, 0.0, 1.0, 1.0))
        
        //RIGHT
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.5, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //TOP
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.5, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0))
        
        //BOTTOM
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //BACK
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //FRONT
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(0.5, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0))
    }
}
