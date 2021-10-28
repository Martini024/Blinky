//
//  GameObject.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    
    private var material = Material()
    
    private var _mesh: Mesh!
    
    init(meshType: MeshType) {
        _mesh = MeshLibrary.mesh(meshType)
    }
    
    override func update(deltaTime: Float) {
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.basic))
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.depthStencilState(.less))
        
        // Vertex Shader
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        // Fragment Shader
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension GameObject {
    public func setColor(_ color: simd_float4) {
        self.material.color = color
        self.material.useMaterialColor = true
    }
}
