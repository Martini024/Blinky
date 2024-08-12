import MetalKit

enum CameraType {
    case debug
}

public class Camera: Node {
    var cameraType: CameraType!
    
    private var _viewMatrix = matrix_identity_float4x4
    var viewMatrix: matrix_float4x4 { return _viewMatrix }
    
    private var _fov: Float = 45.0
    private var _projectionMatrix = matrix_identity_float4x4
    var projectionMatrix: matrix_float4x4 { return _projectionMatrix }
    
    init(name: String, cameraType: CameraType) {
        super.init(name: name)
        self.cameraType = cameraType
    }
    
    override func updateModelMatrix() {
        _viewMatrix = matrix_identity_float4x4
        _viewMatrix.rotate(angle: self.getRotationX(), axis: xAxis)
        _viewMatrix.rotate(angle: self.getRotationY(), axis: yAxis)
        _viewMatrix.rotate(angle: self.getRotationZ(), axis: zAxis)
        _viewMatrix.translate(direction: -getPosition())
    }
    
    func updateProjectionMatrix() {
        _projectionMatrix = matrix_float4x4.perspective(
            degreesFov: self._fov,
            aspectRatio: Renderer.aspectRatio,
            near: 0.1,
            far: 1000)
    }
}

extension Camera {
    func setFov(_ fov: Float) {
        self._fov = fov
        updateProjectionMatrix()
    }
    func zoom(_ delta: Float) { setFov(getFov() + delta) }
    func getFov() -> Float { return self._fov }
}
