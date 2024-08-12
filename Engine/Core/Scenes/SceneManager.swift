import MetalKit

public enum SceneType {
    case sandbox
}

public class SceneManager {
    
    private static var _currentScene: Scene!
    public static var currentScene: Scene { return _currentScene }
    public static func initialize(_ sceneType: SceneType) {
        setScene(sceneType)
    }
    
    public static func setScene(_ sceneType: SceneType) {
        switch sceneType {
        case .sandbox:
            _currentScene = SandboxScene(name: "Sandbox")
        }
    }
    
    public static func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        GameTime.updateTime(deltaTime)
        _currentScene.updateCameras(deltaTime: deltaTime)
        _currentScene.update()
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
