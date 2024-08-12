import MetalKit

enum SceneType {
}

class SceneManager {
    
    private static var _currentScene: Scene?
    
    public static func initialize(_ sceneType: SceneType) {
    }
    
    public static func setScene(_ sceneType: SceneType) {
    }
    
    public static func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        GameTime.updateTime(deltaTime)
        guard let _currentScene = _currentScene else { return }
        _currentScene.updateCameras(deltaTime: deltaTime)
        _currentScene.update()
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
