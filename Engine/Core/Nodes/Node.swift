import MetalKit

open class Node {
    
    private var _name: String = "Node"
    private var _id: String!
    
    private var _position: float3 = float3(repeating: 0)
    private var _scale: float3 = float3(repeating: 1)
    private var _rotation: float3 = float3(repeating: 0)
    
    var parentModelMatrix = matrix_identity_float4x4
    
    private var _modelMatrix = matrix_identity_float4x4
    var modelMatrix: matrix_float4x4 {
        return matrix_multiply(parentModelMatrix, _modelMatrix)
    }
    
    var children: [Node] = []
    
    init(name: String) {
        self._name = name
        self._id = UUID().uuidString
    }
    
    func addChild(_ child: Node) {
        children.append(child)
    }
    
    func updateModelMatrix() {
        _modelMatrix = matrix_identity_float4x4
        _modelMatrix.translate(direction: _position)
        _modelMatrix.rotate(angle: _rotation.x, axis: xAxis)
        _modelMatrix.rotate(angle: _rotation.y, axis: yAxis)
        _modelMatrix.rotate(angle: _rotation.z, axis: zAxis)
        _modelMatrix.scale(axis: _scale)
    }
    
    func afterTranslation() { }
    func afterRotation() { }
    func afterScale() { }
    
    open func doUpdate() { }
    
    func update() {
        doUpdate()
        for child in children {
            child.parentModelMatrix = self.modelMatrix
            child.update()
        }
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.pushDebugGroup("Rendering \(_name)")
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
        for child in children {
            child.render(renderCommandEncoder: renderCommandEncoder)
        }
        renderCommandEncoder.popDebugGroup()
    }
}

extension Node {
    //Naming
    public func setName(_ name: String) { self._name = name }
    public func getName() -> String { return _name }
    public func getId() -> String { return _id }
    
    //Positioning and Movement
    public func setPosition(_ position: float3) {
        self._position = position
        updateModelMatrix()
        afterTranslation()
    }
    public func setPosition(_ x: Float, _ y: Float, _ z: Float) { setPosition(float3(x, y, z)) }
    public func setPositionX(_ xPosition: Float) { setPosition(xPosition, getPositionY(), getPositionZ()) }
    public func setPositionY(_ yPosition: Float) { setPosition(getPositionX(), yPosition, getPositionZ()) }
    public func setPositionZ(_ zPosition: Float) { setPosition(getPositionX(), getPositionY(), zPosition) }
    public func move(_ x: Float, _ y: Float, _ z: Float) { setPosition(getPositionX() + x, getPositionY() + y, getPositionZ() + z) }
    public func moveX(_ delta: Float) { move(delta, 0, 0) }
    public func moveY(_ delta: Float) { move(0, delta, 0) }
    public func moveZ(_ delta: Float) { move(0, 0, delta) }
    public func getPosition()->float3 { return self._position }
    public func getPositionX()->Float { return self._position.x }
    public func getPositionY()->Float { return self._position.y }
    public func getPositionZ()->Float { return self._position.z }
    
    
    //Rotating
    func setRotation(_ rotation: float3) {
        self._rotation = rotation
        updateModelMatrix()
        afterRotation()
    }
    public func setRotation(_ x: Float, _ y: Float, _ z: Float) { setRotation(float3(x, y, z)) }
    public func setRotationX(_ xRotation: Float) { setRotation(xRotation, getRotationY(), getRotationZ()) }
    public func setRotationY(_ yRotation: Float) { setRotation(getRotationX(), yRotation, getRotationZ()) }
    public func setRotationZ(_ zRotation: Float) { setRotation(getRotationX(), getRotationY(), zRotation) }
    public func rotate(_ x: Float, _ y: Float, _ z: Float) { setRotation(getRotationX() + x, getRotationY() + y, getRotationZ() + z) }
    public func rotateX(_ delta: Float) { rotate(delta, 0, 0) }
    public func rotateY(_ delta: Float) { rotate(0, delta, 0) }
    public func rotateZ(_ delta: Float) { rotate(0, 0, delta) }
    public func getRotation() -> float3 { return self._rotation }
    public func getRotationX() -> Float { return self._rotation.x }
    public func getRotationY() -> Float { return self._rotation.y }
    public func getRotationZ() -> Float { return self._rotation.z }
    
    
    //Scaling
    public func setScale(_ scale: float3) {
        self._scale = scale
        updateModelMatrix()
        afterScale()
    }
    public func setScale(_ x: Float,_ y: Float,_ z: Float) { setScale(float3(x,y,z)) }
    public func setScale(_ scale: Float) { setScale(float3(scale, scale, scale)) }
    public func setScaleX(_ scaleX: Float) { setScale(scaleX, getScaleY(), getScaleZ()) }
    public func setScaleY(_ scaleY: Float) { setScale(getScaleX(), scaleY, getScaleZ()) }
    public func setScaleZ(_ scaleZ: Float) { setScale(getScaleX(), getScaleY(), scaleZ) }
    public func scale(_ x: Float, _ y: Float, _ z: Float) { setScale(getScaleX() + x, getScaleY() + y, getScaleZ() + z) }
    public func scaleX(_ delta: Float) { scale(delta, 0, 0) }
    public func scaleY(_ delta: Float) { scale(0, delta, 0) }
    public func scaleZ(_ delta: Float) { scale(0, 0, delta) }
    public func getScale() -> float3 { return self._scale }
    public func getScaleX() -> Float { return self._scale.x }
    public func getScaleY() -> Float { return self._scale.y }
    public func getScaleZ() -> Float { return self._scale.z }
}
