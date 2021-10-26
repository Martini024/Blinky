//
//  SandboxScene.swift
//  Game Engine
//
//  Created by Martini Reinherz on 23/10/21.
//

import MetalKit

class SandboxScene: Scene {
    override func buildScene() {
        let count: Int = 5
        for y in -count..<count {
            for x in -count..<count {
                let player = Player()
                player.position.y = Float(Float(y) + 0.5) / Float(count)
                player.position.x = Float(Float(x) + 0.5) / Float(count)
                player.scale = simd_float3(repeating: 0.1)
                addChild(player)
            }
        }
    }
}
