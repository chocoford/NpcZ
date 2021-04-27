//
//  ConfigView.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/23.
//

import SwiftUI

struct NpcSettingsView: View {
//    @StateObject var npcConfig: NpcConfig = NpcConfig()
    @State var log: String = ""
    @AppStorage("serverAdress") private var serverAdress = ""
    @AppStorage("vkey") private var vkey = ""
    
    var body: some View {
        Form {
            GroupBox(label: Text("服务器地址"), content: {
                TextField("服务器地址", text: $serverAdress)
            })
            GroupBox(label: Text("密钥"), content: {
                TextField("密钥", text: $vkey)
            })

//            HStack{
//                Text("端口")
//                Toggle(isOn: .constant(true)) {
//                    Text("22")
//                }
//                .disabled(true)
//            }
            HStack{
                Button(action: {saveNpcConfig()}, label: {
                    Text("保存")
                        .padding(.horizontal, 20)
                })
                Spacer()
                Text(log)
            }.padding(.top, 10)
        }
        .textFieldStyle(PlainTextFieldStyle())
        .padding()
    }
    
    func saveNpcConfig() {
        log = NpcConfig.createConfFile()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // your code here
            self.log = ""
        }
    }
}

struct NpcSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NpcSettingsView()
    }
}
