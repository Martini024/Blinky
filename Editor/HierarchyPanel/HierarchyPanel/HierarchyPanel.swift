//
//  HierarchyPanel.swift
//  BlinkyEditor
//
//  Created by Martini Reinherz on 12/8/24.
//

import SwiftUI

struct HierarchyPanel: View {
    var body: some View {
        VStack {
        }
        .padding(4)
        .frame(minWidth: 200, maxHeight: .infinity)
        .contentShape(Rectangle())
        .contextMenu(menuItems: {
            HierarchyContextMenu()
        })
    }
}

#Preview {
    HierarchyPanel()
}
