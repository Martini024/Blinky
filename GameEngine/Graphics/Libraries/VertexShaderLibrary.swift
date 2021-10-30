//
//  VertexShaderLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 29/10/21.
//

import MetalKit

enum VertexShaderType {
    case basic
    case instanced
}

class VertexShaderLibrary: Library<VertexShaderType, MTLFunction> {
    private var _library: [VertexShaderType: Shader] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Shader(name: "Basic Vertex Shader", functionName: "basic_vertex_shader"), forKey: .basic)
        _library.updateValue(Shader(name: "Instanced Vertex Shader", functionName: "instanced_vertex_shader"), forKey: .instanced)
    }
    
    override subscript(type: VertexShaderType) -> MTLFunction {
        return _library[type]!.function
    }
}
