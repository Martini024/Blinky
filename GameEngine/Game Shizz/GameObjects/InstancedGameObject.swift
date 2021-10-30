//
//  InstancedGameObject.swift
//  Game Engine
//
//  Created by Martini Reinherz on 28/10/21.
//

import MetalKit

class InstancedGameObject: Node {
    private var _mesh: Mesh!
    var material = Material()
    
    internal var _nodes: [Node] = []
    private var _modelConstants: [ModelConstants] = []
    
    private var _modelConstantBuffer: MTLBuffer!
    
    init(_ meshType: MeshType, instanceCount: Int) {
        super.init()
        self._mesh = Entities.meshes[meshType]
        self._mesh .setInstacneCount(instanceCount)
        generateInstances(instanceCount)
        createBuffers(instanceCount)
    }
    
    private func generateInstances(_ instanceCount: Int) {
        for _ in 0..<instanceCount {
            _nodes.append(Node())
            _modelConstants.append(ModelConstants())
        }
    }
    
    private func createBuffers(_ instanceCount: Int) {
        _modelConstantBuffer = Engine.device.makeBuffer(length: ModelConstants.stride(instanceCount), options: [])
    }
    
    override func update(deltaTime: Float) {
        updteModelConstantsBuffer()
        super.update(deltaTime: deltaTime)
    }
    
    private func updteModelConstantsBuffer() {
        var pointer = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: _modelConstants.count)
        for node in _nodes {
            pointer.pointee.modelMatrix = matrix_multiply(self.modelMatrix, node.modelMatrix)
            pointer = pointer.advanced(by: 1)
        }
    }
}

extension InstancedGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.renderPipelineStates[.instanced])
        renderCommandEncoder.setDepthStencilState(Graphics.depthStencilStates[.less])
        
        // Vertex Shader
        renderCommandEncoder.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)
        
        // Fragment Shader
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension InstancedGameObject {
    public func setColor(_ color: simd_float4) {
        self.material.color = color
        self.material.useMaterialColor = true
    }
}
