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

        var vertices: [Vertex]!
        var vertexBuffer: MTLBuffer!
        
        init(_ parent: MetalView, mtkView: MTKView) {
            self.parent = parent
            self.mtkView = mtkView
            
            let device = MTLCreateSystemDefaultDevice()
            mtkView.device = device
            Engine.initialize(device: device!)
            
            mtkView.clearColor = Preferences.clearColor
            mtkView.colorPixelFormat = Preferences.mainPixelFormat
            
            super.init()
            
            createVertices()
            createBuffers()
        }
        
        private func createVertices() {
            vertices = [
                Vertex(position: simd_float3( 0, 1, 0), color: simd_float4(1,0,0,1)),
                Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,1,0,1)),
                Vertex(position: simd_float3( 1,-1, 0), color: simd_float4(0,0,1,1))
            ]
        }
        
        private func createBuffers() {
            vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        
        func draw(in view: MTKView) {
            guard let drawable = mtkView.currentDrawable,
                  let renderPassDescriptor = mtkView.currentRenderPassDescriptor else { return }
            let commandBuffer = Engine.commandQueue.makeCommandBuffer()
            
            let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
            
            renderCommandEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.pipelineState(.basic))
            renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
            
            renderCommandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
}
