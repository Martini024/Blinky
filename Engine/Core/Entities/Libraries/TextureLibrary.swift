import MetalKit

public enum TextureType {
    case none
}

class TextureLibrary: Library<TextureType, MTLTexture> {
    private var library: [TextureType : Texture] = [:]
    
    override func fillLibrary() { }
    
    override subscript(_ type: TextureType) -> MTLTexture? {
        return library[type]?.texture
    }
}

public class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "png", origin: MTKTextureLoader.Origin = .topLeft) {
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext, origin: origin)
        let texture: MTLTexture = textureLoader.loadTextureFromBundle()
        setTexture(texture)
    }
    
    func setTexture(_ texture: MTLTexture) {
        self.texture = texture
    }
}

class TextureLoader {
    private var _textureName: String!
    private var _textureExtension: String!
    private var _origin: MTKTextureLoader.Origin!
    
    init(textureName: String, textureExtension: String = "png", origin: MTKTextureLoader.Origin = .topLeft) {
        self._textureName = textureName
        self._textureExtension = textureExtension
        self._origin = origin
    }
    
    public func loadTextureFromBundle()->MTLTexture{
        var result: MTLTexture!
        if let url = Bundle(for: type(of: self)).url(forResource: _textureName, withExtension: self._textureExtension) {
            let textureLoader = MTKTextureLoader(device: Engine.device)
            
            let options: [MTKTextureLoader.Option : Any] = [
                MTKTextureLoader.Option.origin : _origin as Any,
                MTKTextureLoader.Option.generateMipmaps: true
            ]
            
            do{
                result = try textureLoader.newTexture(URL: url, options: options)
                result.label = _textureName
            }catch let error as NSError {
                print("ERROR::CREATING::TEXTURE::__\(_textureName!)__::\(error)")
            }
        }else {
            print("ERROR::CREATING::TEXTURE::__\(_textureName!) does not exist")
        }
        
        return result
    }
}
