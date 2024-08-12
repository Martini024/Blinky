import SwiftUI
import BlinkyEngine

struct HierarchyContextMenu: View {
    var body: some View {
        Button("Create Empty") {
            SceneManager.currentScene.addChild(GameObject(name: "Test", meshType: .cube))
        }
    }
}

#Preview {
    HierarchyContextMenu()
}
