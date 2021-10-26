//
//  Camera.swift
//  Game Engine
//
//  Created by Martini Reinherz on 26/10/21.
//
import MetalKit

enum CameraType {
    case debug
}

protocol Camera {
    var cameraType: CameraType { get }
    var position: simd_float3 { get set }
    func update(deltaTime: Float)
}

extension Camera {
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.translate(direction: -position)
        return viewMatrix
    }
}
