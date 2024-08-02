//
//  ColorUtil.swift
//  Game Engine
//
//  Created by Martini Reinherz on 27/10/21.
//

import MetalKit

class ColorUtil {
    public static var randomColor: float4 {
        return float4(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1.0)
    }
}
