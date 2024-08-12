import MetalKit

public class DebugCamera: Camera {
    private var _projectionMatrix = matrix_identity_float4x4
    override var projectionMatrix: matrix_float4x4 { return _projectionMatrix }
    
    private var _moveSpeed: Float = 4.0
    private var _rotateSpeed: Float = 1.0
    
    init() {
        super.init(name: "Debug Camera", cameraType: .debug)
        _projectionMatrix = matrix_float4x4.perspective(degreesFov: 45.0,
                                                        aspectRatio: Renderer.aspectRatio,
                                                        near: 0.1,
                                                        far: 1000)
    }
    
    public override func doUpdate() {
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
        
        self.moveZ(-Mouse.getDWheel() * 0.1)
    }
}
