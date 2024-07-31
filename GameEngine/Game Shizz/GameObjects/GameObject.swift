//
//  GameObject.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    
    private var _material = Material()
    private var _textureType: TextureType = .none
    
    private var _mesh: Mesh!
    
    init(meshType: MeshType) {
        _mesh = Entities.meshes[meshType]
    }
    
    override func update() {
        updateModelConstants()
        super.update()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.renderPipelineStates[.basic])
        renderCommandEncoder.setDepthStencilState(Graphics.depthStencilStates[.less])
        renderCommandEncoder.setFragmentSamplerState(Graphics.samplerStates[.linear], index: 0)
        
        // Vertex Shader
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        // Fragment Shader
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 1)
        if (_material.useTexture) {
            renderCommandEncoder.setFragmentTexture(Entities.textures[_textureType], index: 0)
        }
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension GameObject {
    public func setMaterialColor(_ color: simd_float4) {
        self._material.color = color
        self._material.useMaterialColor = true
        self._material.useTexture = false
    }
    
    public func setTexture(_ textureType: TextureType) {
        self._textureType = textureType
        self._material.useTexture = true
        self._material.useMaterialColor = false
    }
    
    // Lit
    public func setMaterialIsLit(_ isLit: Bool) { self._material.isLit = isLit }
    public func getMaterialIsLit() -> Bool { return self._material.isLit }

    // Ambient
    public func setMaterialAmbient(_ ambient: simd_float3) { self._material.ambient = ambient }
    public func setMaterialAmbient(_ ambient: Float) { self._material.ambient = simd_float3(ambient, ambient, ambient) }
    public func addMaterialAmbient(_ value: Float) { self._material.ambient += value }
    public func getMaterialAmbient() -> simd_float3 { return self._material.ambient }
}
