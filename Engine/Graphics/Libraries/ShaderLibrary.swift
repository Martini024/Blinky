import MetalKit

enum ShaderType {
    case basicVertex
    case instancedVertex
    
    case basicFragment
}

class ShaderLibrary: Library<ShaderType, MTLFunction> {
    private var _library: [ShaderType: Shader] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Shader(functionName: "basic_vertex_shader"), forKey: .basicVertex)
        _library.updateValue(Shader(functionName: "instanced_vertex_shader"), forKey: .instancedVertex)
        
        _library.updateValue(Shader(functionName: "basic_fragment_shader"), forKey: .basicFragment)
    }
    
    override subscript(type: ShaderType) -> MTLFunction {
        return _library[type]!.function
    }
}

class Shader {
    var function: MTLFunction!
    init(functionName: String) {
        self.function = Engine.defaultLibrary.makeFunction(name: functionName)
        self.function.label = functionName
    }
}
