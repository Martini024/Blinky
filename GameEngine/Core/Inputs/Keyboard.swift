//
//  Keyboard.swift
//  Game Engine
//
//  Created by Martini Reinherz on 26/10/21.
//

class Keyboard {
    private static var keyCount: Int = 256
    private static var keys = [Bool].init(repeating: false, count: keyCount)
    
    public static func setKeyPressed(_ keyCode: UInt16, isOn: Bool) {
        keys[Int(keyCode)] = isOn
    }
    
    public static func isKeyPressed(_ keyCode: KeyCode)->Bool{
        return keys[Int(keyCode.rawValue)]
    }
}
