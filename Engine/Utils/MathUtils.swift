import MetalKit

public var xAxis: float3 {
    return float3(1, 0, 0)
}

public var yAxis: float3 {
    return float3(0, 1, 0)
}

public var zAxis: float3 {
    return float3(0, 0, 1)
}

extension matrix_float4x4 {
    mutating func translate(direction: float3) {
        var result = matrix_identity_float4x4
        
        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z
        
        result.columns = (
            float4(1,0,0,0),
            float4(0,1,0,0),
            float4(0,0,1,0),
            float4(x,y,z,1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func scale(axis: float3) {
        var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        result.columns = (
            float4(x,0,0,0),
            float4(0,y,0,0),
            float4(0,0,z,0),
            float4(0,0,0,1)
        )
        
        self = matrix_multiply(self, result)
    }
    
    mutating func rotate(angle: Float, axis: float3) {
        var result = matrix_identity_float4x4
        
        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z
        
        let c: Float = cos(angle)
        let s: Float = sin(angle)
        
        let mc: Float = (1 - c)
        
        let r1c1: Float = x * x * mc + c
        let r2c1: Float = x * y * mc + z * s
        let r3c1: Float = x * z * mc - y * s
        let r4c1: Float = 0.0
        
        let r1c2: Float = y * x * mc - z * s
        let r2c2: Float = y * y * mc + c
        let r3c2: Float = y * z * mc + x * s
        let r4c2: Float = 0.0
        
        let r1c3: Float = z * x * mc + y * s
        let r2c3: Float = z * y * mc - x * s
        let r3c3: Float = z * z * mc + c
        let r4c3: Float = 0.0
        
        let r1c4: Float = 0.0
        let r2c4: Float = 0.0
        let r3c4: Float = 0.0
        let r4c4: Float = 1.0
        
        result.columns = (
            float4(r1c1, r2c1, r3c1, r4c1),
            float4(r1c2, r2c2, r3c2, r4c2),
            float4(r1c3, r2c3, r3c3, r4c3),
            float4(r1c4, r2c4, r3c4, r4c4)
        )
        
        self = matrix_multiply(self, result)
    }
    
    //https://gamedev.stackexchange.com/questions/120338/what-does-a-perspective-projection-matrix-look-like-in-opengl
    static func perspective(degreesFov: Float, aspect: Float, near: Float, far: Float) -> matrix_float4x4 {
        let fov = degreesFov.toRadians
        
        let t: Float = tan(fov / 2)
        
        let x: Float = 1 / (aspect * t)
        let y: Float = 1 / t
        let z: Float = -((far + near) / (far - near))
        let w: Float = -((2 * far * near) / (far - near))
        
        var result = matrix_identity_float4x4
        result.columns = (
            float4(x, 0, 0,  0),
            float4(0, y, 0,  0),
            float4(0, 0, z, -1),
            float4(0, 0, w,  0)
        )
        return result
    }
    
    static func orthographic(orthographicSize: Float, aspect: Float, near: Float, far: Float) -> matrix_float4x4 {
        // Calculate the width and height based on the orthographic size and aspect ratio
        let height = orthographicSize * 2.0
        let width = height * aspect
        
        // Calculate the distances for the near and far planes
        let zRange = far - near
        let zNear = near
        let zFar = far
        
        // Create the orthographic projection matrix
        let scaleX = 2.0 / width
        let scaleY = 2.0 / height
        let scaleZ = -2.0 / zRange
        let translateZ = -(zFar + zNear) / zRange
        
        var matrix = matrix_float4x4(columns: (
            SIMD4<Float>(scaleX, 0, 0, 0),
            SIMD4<Float>(0, scaleY, 0, 0),
            SIMD4<Float>(0, 0, scaleZ, 0),
            SIMD4<Float>(0, 0, translateZ, 1)
        ))
        
        return matrix
    }
}

extension Float {
    var toRadians: Float {
        return (self / 180.0) * Float.pi
    }
    
    var toDegrees: Float {
        return self * (180.0 / Float.pi)
    }
}
