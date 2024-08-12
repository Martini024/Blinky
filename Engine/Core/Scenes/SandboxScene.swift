class SandboxScene: Scene {
    override func buildScene() {
        let camera = DebugCamera()
        camera.setPosition(0, 0, 8)
        addCamera(camera)
    }
}
