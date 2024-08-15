import MetalKit

public class Renderer: NSObject {
    public static var screenSize = float2(repeating: 0)
    public static var aspectRatio: Float {
        screenSize.x / screenSize.y
    }
    static var lastFrameTime: Float = 0
    
    init(_ frame: CGSize) {
        super.init()
        updateScreenSize(frame)
    }
}

extension Renderer: MTKViewDelegate {

    public func updateScreenSize(_ frame: CGSize) {
        Renderer.screenSize = float2(Float(frame.width), Float(frame.height))
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    public func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.commandQueue.makeCommandBuffer()
        commandBuffer?.label = "My Command Buffer"
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.label = "Fist Render Command Encoder"
        
        renderCommandEncoder?.pushDebugGroup("Starting Render")
        
        let currentTime = Float(CFAbsoluteTimeGetCurrent())
        let deltaTime: Float
        if Renderer.lastFrameTime == 0 {
            deltaTime = 1.0 / Float(view.preferredFramesPerSecond)
        } else {
            deltaTime = currentTime - Renderer.lastFrameTime
        }
        Renderer.lastFrameTime = currentTime
        SceneManager.tickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime: deltaTime)

        renderCommandEncoder?.popDebugGroup()
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
}
