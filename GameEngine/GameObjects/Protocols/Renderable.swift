//
//  Renderable.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

protocol Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
