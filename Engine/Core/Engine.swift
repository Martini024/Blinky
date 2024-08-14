import Metal

class Engine {
    public static var device: MTLDevice!
    public static var commandQueue: MTLCommandQueue!
    public static var defaultLibrary: MTLLibrary!
    
    public static func initialize(device: MTLDevice) {
        Log.initialize()
        
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        self.defaultLibrary = try! device.makeDefaultLibrary(bundle: Bundle(for: self))
        Graphics.initialize()
        
        Entities.initialize()
        
        SceneManager.initialize(Preferences.startingSceneType)
    }
}
