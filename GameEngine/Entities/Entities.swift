//
//  Entities.swift
//  Game Engine
//
//  Created by Martini Reinherz on 29/10/21.
//

import Foundation

class Entities {
    private static var _meshLibrary: MeshLibrary!
    public static var meshes: MeshLibrary { return _meshLibrary }
    
    private static var _textureLibrary: TextureLibrary!
    public static var textures: TextureLibrary { return _textureLibrary }
    
    public static func initialize() {
        self._meshLibrary = MeshLibrary()
        self._textureLibrary = TextureLibrary()
    }
}
