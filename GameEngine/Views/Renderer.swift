import MetalKit

class Renderer: NSObject {
    public static var screenSize = float2(repeating: 0)
    public static var aspectRatio: Float {
        screenSize.x / screenSize.y
    }
    
    init(_ frame: CGSize) {
        super.init()
        updateScreenSize(frame)
    }
}

extension Renderer: MTKViewDelegate {
    
    public func updateScreenSize(_ frame: CGSize) {
        Renderer.screenSize = float2(Float(frame.width), Float(frame.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.commandQueue.makeCommandBuffer()
        commandBuffer?.label = "My Command Buffer"
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.label = "Fist Render Command Encoder"
        
        renderCommandEncoder?.pushDebugGroup("Starting Render")
        SceneManager.tickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        renderCommandEncoder?.popDebugGroup()
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
}
