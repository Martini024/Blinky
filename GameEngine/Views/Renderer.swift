//
//  Renderer.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class Renderer: NSObject {
    
    var player = Player()
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.commandQueue.makeCommandBuffer()
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        player.update(deltaTime: 1 / Float(view.preferredFramesPerSecond))
        player.render(renderCommandEncoder: renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
