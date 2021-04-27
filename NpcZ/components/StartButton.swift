//
//  StartButton.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/23.
//

import SwiftUI

struct StartButton: View {
    @EnvironmentObject var npcCore: NpcCore
    var statusItem: NSStatusItem?
    
    var body: some View {
        Button(action: {
            if npcCore.isRunning {
                npcCore.stop()
            } else {
                npcCore.start()
            }
        },label: {
            Image(npcCore.isRunning ? "stop" : "start")
        })
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        StartButton()
    }
}
