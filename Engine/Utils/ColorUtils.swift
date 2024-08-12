import MetalKit

class ColorUtils {
    public static var randomColor: float4 {
        return float4(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1.0)
    }
}
