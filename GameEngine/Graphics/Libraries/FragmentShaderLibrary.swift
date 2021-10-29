//
//  FragmentShaderLibrary.swift
//  Game Engine
//
//  Created by Martini Reinherz on 29/10/21.
//

import MetalKit

enum FragmentShaderType {
    case basic
}

class FragmentShaderLibrary: Library<FragmentShaderType, MTLFunction> {
    private var _library: [FragmentShaderType: Shader] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Shader(name: "Basic Fragment Shader", functionName: "basic_fragment_shader"), forKey: .basic)
    }
    
    override subscript(type: FragmentShaderType) -> MTLFunction? {
        return (_library[type]?.function)!
    }
}
