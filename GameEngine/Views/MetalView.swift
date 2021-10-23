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
    
    func updateNSView(_ nsView: MTKView, context: Context) { }
    
    func makeCoordinator() -> Renderer {
        let device = MTLCreateSystemDefaultDevice()
        mtkView.device = device
        Engine.initialize(device: device!)
        mtkView.clearColor = Preferences.clearColor
        mtkView.colorPixelFormat = Preferences.mainPixelFormat
        return Renderer()
    }
}
