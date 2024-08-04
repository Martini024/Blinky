//
//  Chest.swift
//  Game Engine
//
//  Created by Martini Reinherz on 4/8/24.
//

class Chest: GameObject {
    init() {
        super.init(name: "Chest", meshType: .chest)
        self.setScale(0.01)
    }
}
