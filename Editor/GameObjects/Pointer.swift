import Foundation
import BlinkyEngine

class Pointer: GameObject {
    
    private var camera: Camera!
    
    init(camera: Camera) {
        super.init(name: "Pointer", meshType: .triangle)
        self.camera = camera
    }
    
    override func doUpdate() {
        self.rotateZ(-atan2f(
            Mouse.getMouseViewportPosition().x - getPositionX() + camera.getPositionX(),
            Mouse.getMouseViewportPosition().y - getPositionY() + camera.getPositionY()))
    }
}
