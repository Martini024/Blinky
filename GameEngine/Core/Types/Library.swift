//
//  Library.swift
//  Game Engine
//
//  Created by Martini Reinherz on 29/10/21.
//

import Foundation

class Library<T, K> {
    init() {
        fillLibrary()
    }
    
    // Override this function when filling the library with default values
    func fillLibrary () {
            
    }
    
    subscript(_ type: T) -> K? {
        return nil
    }
}
