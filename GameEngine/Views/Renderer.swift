//
//  Renderer.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class Renderer: NSObject {
    public static var screenSize = simd_float2(repeating: 0)
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
        Renderer.screenSize = simd_float2(Float(frame.width), Float(frame.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.commandQueue.makeCommandBuffer()
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        SceneManager.tickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
