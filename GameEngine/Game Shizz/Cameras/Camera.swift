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

class Camera: Node {
    var cameraType: CameraType!
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.rotate(angle: self.getRotationX(), axis: xAxis)
        viewMatrix.rotate(angle: self.getRotationY(), axis: yAxis)
        viewMatrix.rotate(angle: self.getRotationZ(), axis: zAxis)
        viewMatrix.translate(direction: -getPosition())
        return viewMatrix
    }
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_identity_float4x4
    }
    
    init(cameraType: CameraType) {
        super.init(name: "Camera")
        self.cameraType = cameraType
    }
}
