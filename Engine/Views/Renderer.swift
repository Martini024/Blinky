import MetalKit

public class Renderer: NSObject {
    var screenSize = float2(repeating: 0)
    var aspectRatio: Float { screenSize.x / screenSize.y }
    
    private var _scene: Scene?

    var lastFrameTime: Float = 0

    init(_ frame: CGSize) {
        super.init()
        updateScreenSize(frame)
    }
}

extension Renderer {
    func updateScreenSize(_ frame: CGSize) {
        screenSize = float2(Float(frame.width), Float(frame.height))
    }
}

extension Renderer {
    func tickScene(_ renderCommandEncoder: MTLRenderCommandEncoder, _ deltaTime: Float) {
        GameTime.updateTime(deltaTime)
        guard let scene = _scene else { return }
        scene.updateCameras(deltaTime: deltaTime)
        scene.update()
        scene.render(renderCommandEncoder: renderCommandEncoder)
    }
}

extension Renderer {
    func setScene(_ scene: Scene) { _scene = scene }
}

extension Renderer: MTKViewDelegate {
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    public func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        guard let commandBuffer = Engine.commandQueue.makeCommandBuffer() else { return }
        commandBuffer.label = "My Command Buffer"
        
        guard let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }
        renderCommandEncoder.label = "Fist Render Command Encoder"
        
        renderCommandEncoder.pushDebugGroup("Starting Render")
        
        let currentTime = Float(CFAbsoluteTimeGetCurrent())
        let deltaTime: Float
        if lastFrameTime == 0 {
            deltaTime = 1.0 / Float(view.preferredFramesPerSecond)
        } else {
            deltaTime = currentTime - lastFrameTime
        }
        lastFrameTime = currentTime
        tickScene(renderCommandEncoder, deltaTime)

        renderCommandEncoder.popDebugGroup()
        
        renderCommandEncoder.endEncoding()
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
    }
}
