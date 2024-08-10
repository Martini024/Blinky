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
