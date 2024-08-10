import SwiftUI

@main
struct GameEngineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some SwiftUI.Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: 1024, idealWidth: 1024, maxWidth: .infinity, minHeight: 720, idealHeight: 720, maxHeight: .infinity)
        }
    }
}
