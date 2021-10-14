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

        var vertices: [Vertex]!
        var vertexBuffer: MTLBuffer!
        
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
            createVertices()
            createBuffers()
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
        
        private func createVertices() {
            vertices = [
                Vertex(position: SIMD3<Float>( 0, 1, 0), color: SIMD4<Float>(1,0,0,1)),
                Vertex(position: SIMD3<Float>(-1,-1, 0), color: SIMD4<Float>(0,1,0,1)),
                Vertex(position: SIMD3<Float>( 1,-1, 0), color: SIMD4<Float>(0,0,1,1))
            ]
        }
        private func createBuffers() {
            vertexBuffer = mtkView.device?.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        
        func draw(in view: MTKView) {
            guard let drawable = mtkView.currentDrawable,
                  let renderPassDescriptor = mtkView.currentRenderPassDescriptor else { return }
            let commandBuffer = commandQueue.makeCommandBuffer()
            
            let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
            renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
            
            renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
            
            renderCommandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
}

struct Vertex {
    var position: SIMD3<Float>
    var color: SIMD4<Float>
}
