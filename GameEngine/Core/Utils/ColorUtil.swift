//
//  ColorUtil.swift
//  Game Engine
//
//  Created by Martini Reinherz on 27/10/21.
//

import MetalKit

class ColorUtil {
    public static var randomColor: simd_float4 {
        return simd_float4(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1.0)
    }
}
