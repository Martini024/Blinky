//
//  SceneManager.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum SceneType {
    case sandbox
}

class SceneManager {
    
    private static var _currentScene: Scene!
    
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
