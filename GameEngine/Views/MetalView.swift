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
    private var mtkView: MTKView = GameView()
    var frame: CGSize = .zero
    
    init(_ frame: CGSize) {
        self.frame = frame
    }
    
    func makeNSView(context: Context) -> MTKView {
        mtkView.delegate = context.coordinator
        return mtkView
    }
    
    func updateNSView(_ nsView: MTKView, context: Context) {
        context.coordinator.updateScreenSize(frame)
    }
    
    func makeCoordinator() -> Renderer {
        let device = MTLCreateSystemDefaultDevice()
        mtkView.device = device
        Engine.initialize(device: device!)
        mtkView.clearColor = Preferences.clearColor
        mtkView.colorPixelFormat = Preferences.mainPixelFormat
        mtkView.depthStencilPixelFormat = Preferences.mainDepthPixelFormat
        return Renderer(frame)
    }
}

class GameView: MTKView { }

// MARK: Keyboard Input
extension GameView {
    override var acceptsFirstResponder: Bool { true }
    
    override func keyDown(with event: NSEvent) {
        Keyboard.setKeyPressed(event.keyCode, isOn: true)
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.setKeyPressed(event.keyCode, isOn: false)
    }
}

// MARK: Mouse Button Input
extension GameView {
    override func mouseDown(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func mouseUp(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func rightMouseUp(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    override func otherMouseDown(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func otherMouseUp(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
}

// MARK: Mouse Movement
extension GameView {
    override func mouseMoved(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    override func scrollWheel(with event: NSEvent) {
        Mouse.scrollMouse(deltaY: Float(event.deltaY))
    }
    
    override func mouseDragged(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    override func rightMouseDragged(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    override func otherMouseDragged(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    private func setMousePositionChanged(event: NSEvent){
        let overallLocation = float2(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let deltaChange = float2(Float(event.deltaX), Float(event.deltaY))
        Mouse.setMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    
    override func updateTrackingAreas() {
        let area = NSTrackingArea(
            rect: self.bounds,
            options:
                [
                    NSTrackingArea.Options.activeAlways,
                    NSTrackingArea.Options.mouseMoved,
                    NSTrackingArea.Options.enabledDuringMouseDrag
                ],
            owner: self,
            userInfo: nil
        )
        self.addTrackingArea(area)
    }
    
}
