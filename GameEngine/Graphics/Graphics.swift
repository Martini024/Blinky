//
//  Graphics.swift
//  Game Engine
//
//  Created by Martini Reinherz on 29/10/21.
//

import Foundation

class Graphics {
    
    private static var _vertexShaderLibrary: VertexShaderLibrary!
    public static var vertexShaders: VertexShaderLibrary { return _vertexShaderLibrary }
    
    private static var _fragmentShaderLibrary: FragmentShaderLibrary!
    public static var fragmentShaders: FragmentShaderLibrary { return _fragmentShaderLibrary }
    
    private static var _vertexDescriptorLibrary: VertexDescriptorLibrary!
    public static var vertexDescriptors: VertexDescriptorLibrary { return _vertexDescriptorLibrary }
    
    public static func initialize() {
        self._vertexShaderLibrary = VertexShaderLibrary()
        self._fragmentShaderLibrary = FragmentShaderLibrary()
        self._vertexDescriptorLibrary = VertexDescriptorLibrary()
    }
}
