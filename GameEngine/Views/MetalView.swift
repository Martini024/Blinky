//
//  MetalView.swift
//  GameEngine
//
//  Created by Martini Reinherz on 12/10/21.
//

import SwiftUI
import MetalKit

struct MetalView: NSViewRepresentable {
    typealias NSViewType = MTKView
    private var mtkView: MTKView = MTKView()
    
    func makeNSView(context: Context) -> MTKView {
        mtkView.delegate = context.coordinator
        return mtkView
    }
    
    func updateNSView(_ nsView: MTKView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, mtkView: mtkView)
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        var parent: MetalView
        var mtkView: MTKView
        var commandQueue: MTLCommandQueue!
        var renderPipelineState: MTLRenderPipelineState!

        init(_ parent: MetalView, mtkView: MTKView) {
            self.parent = parent
            self.mtkView = mtkView
            
            let device = MTLCreateSystemDefaultDevice()
            mtkView.device = device
            mtkView.clearColor = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35, alpha: 1.0)
            mtkView.colorPixelFormat = .bgra8Unorm
            commandQueue = mtkView.device?.makeCommandQueue()
            
            super.init()
            
            createRenderPipelineState()
        }
        
        private func createRenderPipelineState() {
            let library = mtkView.device?.makeDefaultLibrary()
            let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
            let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
            
            let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
            renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            renderPipelineDescriptor.vertexFunction = vertexFunction
            renderPipelineDescriptor.fragmentFunction = fragmentFunction
            
            do {
                renderPipelineState = try mtkView.device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
            } catch let error as NSError {
                print(error)
            }
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        
        func draw(in view: MTKView) {
            guard let drawable = mtkView.currentDrawable,
                  let renderPassDescriptor = mtkView.currentRenderPassDescriptor else { return }
            let commandBuffer = commandQueue.makeCommandBuffer()
            
            let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
            renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
            
            // Send info to renderCommandEncoder
            renderCommandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
}
