import MetalKit

public class Camera: Node {
    private var _viewMatrix = matrix_identity_float4x4
    var viewMatrix: matrix_float4x4 { return _viewMatrix }
    
    private var _projectionMatrix = matrix_identity_float4x4
    private var _projectionMatrixAutoUpdate = true
    
    private var _orthographic: Bool = false
    
    private var _fieldOfView: Float = 60.0
    private var _orthographicSize: Float = 5.0
    
    private var _aspect: Float = 1.0
    private var _nearClipPlane: Float = 0.1
    private var _farClipPlane: Float = 1000
    
    override func updateModelMatrix() {
        _viewMatrix = matrix_identity_float4x4
        _viewMatrix.rotate(angle: self.getRotationX(), axis: xAxis)
        _viewMatrix.rotate(angle: self.getRotationY(), axis: yAxis)
        _viewMatrix.rotate(angle: self.getRotationZ(), axis: zAxis)
        _viewMatrix.translate(direction: -getPosition())
    }
}

extension Camera {
    public var projectionMatrix: matrix_float4x4 {
        get {
            return _projectionMatrix
        }
        set(projectionMatrix) {
            _projectionMatrixAutoUpdate = false
            _projectionMatrix = projectionMatrix
        }
    }
    
    private func updateProjectionMatrix() {
        if (_orthographic) {
            _projectionMatrix = matrix_float4x4.orthographic(orthographicSize: _orthographicSize, aspect: _aspect, near: _nearClipPlane, far: _farClipPlane)
        } else {
            _projectionMatrix = matrix_float4x4.perspective(degreesFov: _fieldOfView, aspect: _aspect, near: _nearClipPlane, far: _farClipPlane)
        }
    }
    
    public func resetProjectionMatrix() {
        _projectionMatrixAutoUpdate = true
    }
}


extension Camera {
    public var orthographic: Bool {
        get { _orthographic }
        set { 
            _orthographic = newValue
            if (_projectionMatrixAutoUpdate) {
                updateProjectionMatrix()
            }
        }
    }
    
    public var fieldOfView: Float {
        get { _fieldOfView }
        set {
            _fieldOfView = newValue
            if (_projectionMatrixAutoUpdate) {
                updateProjectionMatrix()
            }
        }
    }
    
    public var orthographicSize: Float {
        get { _orthographicSize }
        set {
            _orthographicSize = newValue
            if (_projectionMatrixAutoUpdate) {
                updateProjectionMatrix()
            }
        }
    }
    
    public var aspect: Float {
        get { _aspect }
        set {
            _aspect = newValue
            if (_projectionMatrixAutoUpdate) {
                updateProjectionMatrix()
            }
        }
    }
    
    public var nearClipPlane: Float {
        get { _nearClipPlane }
        set {
            _nearClipPlane = newValue
            if (_projectionMatrixAutoUpdate) {
                updateProjectionMatrix()
            }
        }
    }
    
    public var farClipPlane: Float {
        get { _farClipPlane }
        set {
            _farClipPlane = newValue
            if (_projectionMatrixAutoUpdate) {
                updateProjectionMatrix()
            }
        }
    }
}
