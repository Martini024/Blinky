import MetalKit

open class GameObject: Node {
    
    private var _modelConstants = ModelConstants()
    private var _mesh: Mesh!
    
    private var _material: Material? = nil
    private var _baseColorTextureType: TextureType = .none
    private var _normalMapTextureType: TextureType = .none
    
    public init(name: String, meshType: MeshType) {
        super.init(name: name)
        _mesh = Entities.meshes[meshType]
    }
    
    override func update() {
        _modelConstants.modelMatrix = self.modelMatrix
        super.update()
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.renderPipelineStates[.basic])
        renderCommandEncoder.setDepthStencilState(Graphics.depthStencilStates[.less])
        
        // Vertex Shader
        renderCommandEncoder.setVertexBytes(&_modelConstants, length: ModelConstants.stride, index: 2)
        
        _mesh.drawPrimitives(renderCommandEncoder, 
                             material: _material,
                             baseColorTextureType: _baseColorTextureType,
                             normalMapTextureType: _normalMapTextureType)
    }
}

extension GameObject {
    public func useBaseColorTexture(_ textureType: TextureType) { self._baseColorTextureType = textureType }
    
    public func useNormalMapTexture(_ textureType: TextureType) { self._normalMapTextureType = textureType }

    public func useMaterial(_ material: Material) { _material = material }
}
