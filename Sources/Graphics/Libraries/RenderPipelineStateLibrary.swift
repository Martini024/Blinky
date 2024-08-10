import MetalKit

enum RenderPipelineStateType {
    case basic
    case instanced
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateType, MTLRenderPipelineState> {
    private var _library: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(BasicRenderPipelineState(), forKey: .basic)
        _library.updateValue(InstancedRenderPipelineState(), forKey: .instanced)
    }
    
    override subscript(type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return _library[type]!.renderPipelineState
    }
}

class RenderPipelineState {
    var renderPipelineState: MTLRenderPipelineState!
    init(_ renderPipelineDescriptor: MTLRenderPipelineDescriptor) {
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__::\(error)")
        }
    }
}

class BasicRenderPipelineState: RenderPipelineState {
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Basic Render Pipeline Descriptor"
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.mainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.vertexDescriptors[.basic]
        
        renderPipelineDescriptor.vertexFunction = Graphics.shaders[.basicVertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.shaders[.basicFragment]
        
        super.init(renderPipelineDescriptor)
    }
}

class InstancedRenderPipelineState: RenderPipelineState {
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Instanced Vertext Descriptor"
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.mainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.vertexDescriptors[.basic]
        
        renderPipelineDescriptor.vertexFunction = Graphics.shaders[.instancedVertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.shaders[.basicFragment]
        
        super.init(renderPipelineDescriptor)
    }
}
