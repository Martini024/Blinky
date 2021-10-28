//
//  ShaderLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

enum VertexShaderType {
    case basic
    case instanced
}

enum FragmentShaderType {
    case basic
}

class ShaderLibrary {
    public static var defaultLibrary: MTLLibrary!
    
    private static var vertexShaders: [VertexShaderType: Shader] = [:]
    
    private static var fragmentShaders: [FragmentShaderType: Shader] = [:]

    public static func initialize() {
        defaultLibrary = Engine.device.makeDefaultLibrary()
        createDefaultShaders()
    }
    
    private static func createDefaultShaders() {
        vertexShaders.updateValue(BasicVertexShader(), forKey: .basic)
        vertexShaders.updateValue(InstancedVertexShader(), forKey: .instanced)
        fragmentShaders.updateValue(BasicFragmentShader(), forKey: .basic)
    }
    
    public static func vertex(_ vertexShaderType: VertexShaderType) -> MTLFunction {
        return vertexShaders[vertexShaderType]!.function
    }
    
    public static func fragment(_ fragmentShaderType: FragmentShaderType) -> MTLFunction {
        return fragmentShaders[fragmentShaderType]!.function
    }
}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction! { get }
}

public struct BasicVertexShader: Shader {
    public var name: String = "Basic Vertex Shader"
    public var functionName: String = "basic_vertex_shader"
    public var function: MTLFunction!
    init() {
        function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name
    }
}

public struct InstancedVertexShader: Shader {
    public var name: String = "Instanced Vertex Shader"
    public var functionName: String = "instanced_vertex_shader"
    public var function: MTLFunction!
    init() {
        function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name
    }
}

public struct BasicFragmentShader: Shader {
    public var name: String = "Basic Fragment Shader"
    public var functionName: String = "basic_fragment_shader"
    public var function: MTLFunction!
    init() {
        function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name
    }
}
