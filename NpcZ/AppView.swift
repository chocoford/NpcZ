//
//  AppView.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/24.
//

import SwiftUI


struct AppView: View {
    @EnvironmentObject var npcCore: NpcCore
    
    var body: some View {
        VStack {
            MainView()
            NpcMenuDivider()
//            NpcMenuButton(title: "配置", action: {
//                // FIXME: 还是不行
//                print("did click")
//                if let url = URL(string: "npcz://OtherView") {
//                    openURL(url)
//                }
////                let detailView = NpcSettingsView()
////
////                let controller = ConfigWC(rootView: detailView)
////                controller.window?.title = "新窗口"
////                controller.showWindow(nil)
//            })
            NpcMenuButton(title: "设置", action: {
                print("did click 设置")
                NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
            }, keyEquivalent: "⌘ ,  ")
            NpcMenuDivider()
            NpcMenuButton(title: "退出", action: {
                npcCore.stop()
                NSApplication.shared.terminate(self)
            }, keyEquivalent: "⌘ Q")
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}


class ConfigWC<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 400, height: 500))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 400, height: 500))
        self.init(window: window)
    }
}

//struct DetailView: View {
//    var body: some View {
//        VStack{
//            Spacer()
//           Text("我是新窗口")
//            Spacer()
//        }
//    }
//}
