import MetalKit

public enum ClearColors {
    static let white: MTLClearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let green: MTLClearColor = MTLClearColor(red: 0.22, green: 0.55, blue: 0.34, alpha: 1.0)
    static let gray: MTLClearColor = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let darkGrey: MTLClearColor = MTLClearColor(red: 0.01, green: 0.01, blue: 0.01, alpha: 1.0)
    static let black: MTLClearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1.0)
}

public class Preferences {
    public static var clearColor: MTLClearColor = ClearColors.darkGrey
    public static var mainPixelFormat: MTLPixelFormat = .bgra8Unorm_srgb
    public static var mainDepthPixelFormat: MTLPixelFormat = .depth32Float
}
