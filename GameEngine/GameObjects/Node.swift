//
//  Node.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import Foundation
import MetalKit

class Node {
    
    var position: simd_float3 = simd_float3(repeating: 0)
    var scale: simd_float3 = simd_float3(repeating: 1)
    var rotation: simd_float3 = simd_float3(repeating: 0)
    
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: position)
        modelMatrix.rotate(angle: rotation.x, axis: xAxis)
        modelMatrix.rotate(angle: rotation.y, axis: yAxis)
        modelMatrix.rotate(angle: rotation.z, axis: zAxis)
        modelMatrix.scale(axis: scale)
        return modelMatrix
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
    }
}
