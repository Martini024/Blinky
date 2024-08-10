import MetalKit

class DebugCamera: Camera {
    private var _zoom: Float = 45.0
    
    private var _moveSpeed: Float = 4.0
    private var _rotateSpeed: Float = 1.0
    
    init() {
        super.init(name: "Debug Camera", cameraType: .debug)
    }
    
    override func doUpdate() {
        if (Keyboard.isKeyPressed(.leftArrow)) {
            self.moveX(GameTime.deltaTime * _moveSpeed)
        }
        
        if (Keyboard.isKeyPressed(.rightArrow)) {
            self.moveX(-GameTime.deltaTime * _moveSpeed)
        }
        
        if (Keyboard.isKeyPressed(.upArrow)) {
            self.moveY(-GameTime.deltaTime * _moveSpeed)
        }
        
        if (Keyboard.isKeyPressed(.downArrow)) {
            self.moveY(GameTime.deltaTime * _moveSpeed)
        }
        
        if (Mouse.isMouseButtonPressed(button: .right)) {
            self.rotate(Mouse.getDY() * GameTime.deltaTime * _rotateSpeed,
                        Mouse.getDX() * GameTime.deltaTime * _rotateSpeed,
                        0)
        }
        
        self.zoom(-Mouse.getDWheel())
    }
}
