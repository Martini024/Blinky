import MetalKit

public enum MouseButtonCode: Int {
    case left
    case right
    case center
}

public class Mouse {
    private static var mouseButtonCount = 12
    private static var mouseButtons = [Bool].init(repeating: false, count: mouseButtonCount)
    
    private static var overallMousePosition = float2(repeating: 0)
    private static var mousePositionDelta = float2(repeating: 0)
    
    private static var scrollWheelPosition: Float = 0
    private static var lastWheelPosition: Float = 0.0
    
    private static var scrollWheelChange: Float = 0.0
    
    public static func setMouseButtonPressed(button: Int, isOn: Bool){
        mouseButtons[button] = isOn
    }
    
    public static func isMouseButtonPressed(button: MouseButtonCode)->Bool{
        return mouseButtons[Int(button.rawValue)] == true
    }
    
    public static func setOverallMousePosition(position: float2){
        self.overallMousePosition = position
    }
    
    ///Sets the delta distance the mouse had moved
    public static func setMousePositionChange(overallPosition: float2, deltaPosition: float2){
        self.overallMousePosition = overallPosition
        self.mousePositionDelta = deltaPosition
    }
    
    public static func scrollMouse(deltaY: Float){
        scrollWheelPosition += deltaY
        scrollWheelChange += deltaY
    }
    
    //Returns the overall position of the mouse on the current window
    public static func getMouseWindowPosition()->float2{
        return overallMousePosition
    }
    
    ///Returns the movement of the wheel since last time getDWheel() was called
    public static func getDWheel()->Float{
        let position = scrollWheelChange
        scrollWheelChange = 0
        return -position
    }
    
    ///Movement on the y axis since last time getDY() was called.
    public static func getDY()->Float{
        let result = mousePositionDelta.y
        mousePositionDelta.y = 0
        return result
    }
    
    ///Movement on the x axis since last time getDX() was called.
    public static func getDX()->Float{
        let result = mousePositionDelta.x
        mousePositionDelta.x = 0
        return result
    }
    
    ///Returns the mouse position in screen-view coordinates [-1, 1]
    // TODO: move this to camera
//    public static func getMouseViewportPosition() -> float2 {
//        let x = (overallMousePosition.x - Renderer.screenSize.x * 0.5) / (Renderer.screenSize.x * 0.5)
//        let y = (overallMousePosition.y - Renderer.screenSize.y * 0.5) / (Renderer.screenSize.y * 0.5)
//        return float2(x, y)
//    }
}
