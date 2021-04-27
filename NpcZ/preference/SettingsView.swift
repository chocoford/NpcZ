//
//  Preference.swift
//  NpcZ
//
//  Created by Chocoford on 2021/4/26.
//

import SwiftUI
struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, npc
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            NpcSettingsView()
                .tabItem {
                    Label("Advanced", systemImage: "star")
                }
                .tag(Tabs.npc)
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
