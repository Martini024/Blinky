//
//  InstancedGameObject.swift
//  Game Engine
//
//  Created by Martini Reinherz on 28/10/21.
//

import MetalKit

class InstancedGameObject: Node {
    private var _mesh: Mesh!
    private var _material = Material()
    
    internal var _nodes: [Node] = []
    
    private var _modelConstantBuffer: MTLBuffer!
    
    init(_ meshType: MeshType, instanceCount: Int) {
        super.init(name: "Instanced Game Object")
        self._mesh = Entities.meshes[meshType]
        self._mesh .setInstanceCount(instanceCount)
        generateInstances(instanceCount)
        createBuffers(instanceCount)
    }
    
    private func generateInstances(_ instanceCount: Int) {
        for _ in 0..<instanceCount {
            _nodes.append(Node(name: "\(getName())_InstancedNode"))
        }
    }
    
    private func createBuffers(_ instanceCount: Int) {
        _modelConstantBuffer = Engine.device.makeBuffer(length: ModelConstants.stride(instanceCount), options: [])
    }
    
    override func update() {
        var pointer = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: _nodes.count)
        for node in _nodes {
            pointer.pointee.modelMatrix = matrix_multiply(self.modelMatrix, node.modelMatrix)
            pointer = pointer.advanced(by: 1)
        }
        super.update()
    }
}

extension InstancedGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.renderPipelineStates[.instanced])
        renderCommandEncoder.setDepthStencilState(Graphics.depthStencilStates[.less])
        
        // Vertex Shader
        renderCommandEncoder.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)
        
        // Fragment Shader
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 1)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension InstancedGameObject {
    public func setColor(_ color: float4) {
        self._material.color = color
        self._material.useMaterialColor = true
    }
    
    public func setColor(_ r: Float,_ g: Float,_ b: Float,_ a: Float) {
        setColor(float4(r,g,b,a))
    }
}
