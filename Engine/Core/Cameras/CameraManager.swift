import MetalKit

class CameraManager {
    
    private var _cameras: [CameraType: Camera] = [:]
    
    public var currentCamera: Camera!
    
    public func registerCamera(camera: Camera){
        self._cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: CameraType){
        self.currentCamera = _cameras[cameraType]
    }
    
    internal func update(){
        for camera in _cameras.values {
            camera.update()
        }
    }
    
}
