//
//  ContentView.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/20.
//

import SwiftUI


struct MainView: View {
    @EnvironmentObject var npcCore: NpcCore

    var body: some View {
        VStack {
            StartButton()
            .frame(width: 128, height: 128, alignment: .center)
            .padding()
            ///indicator
            HStack{
                Circle()
                    .fill(npcCore.isRunning ? Color.green : Color.red)
                    .frame(width: 10.0, height: 10.0)
                Text(npcCore.isRunning ? "已启动" : "未启动")
                
            }
            Text(npcCore.infoLog)
//            TrafficProgressView().padding()
//            TextEditor(text: .constant(npcCore.npcLog)).padding()
        }
        .environmentObject(npcCore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
//                    print(Bundle.main.resourcePath!+"/npc")
//                    try! NSUserUnixTask(url: URL(fileURLWithPath: Bundle.main.resourcePath!+"/npc")).execute(withArguments: ["-server", server, "-vkey", idKey]) { (error) in
//                        if let error = error {
//                            print("Failed: ", error)
//                        }
//                    }
