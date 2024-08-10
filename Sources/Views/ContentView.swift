//
//  ContentView.swift
//  GameEngine
//
//  Created by Martini Reinherz on 12/10/21.
//

import SwiftUI
import CoreData
import MetalKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        GeometryReader { geometry in
            MetalView(geometry.size)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
