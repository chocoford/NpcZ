//
//  NPC_ZApp.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/20.
//

import SwiftUI
import ServiceManagement

var appVersion: String { return "\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] ?? "" )" }

enum AppState: String {
    case started
    case stopped
}

@main
struct NPC_ZApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isRunning: Bool = false
    @AppStorage("startOnBoot") var startOnBoot: Bool = false

    init() {
        let npcCore = NpcCore()
        _ = NpcConfig.createConfFile()

        let view = NSHostingView(rootView: AppView().environmentObject(npcCore))
        // Don't forget to set the frame, otherwise it won't be shown.
        view.frame = NSRect(x: 0, y: 0, width: 200, height: 320)
        
        let menuItem = NSMenuItem()
        menuItem.view = view
        
        let menu = NSMenu()
        menu.addItem(menuItem)
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.menu = menu
        statusItem.button?.image = NSImage(named: NSImage.Name("menubar-off"))
        
        // FIXME: 非常不优雅的方式
        npcCore.barButton = statusItem.button
        
        
        /// 开机自启动相关
//        let launcherAppId = "com.chocoford.NpcZLauncher"
//        let runningApps = NSWorkspace.shared.runningApplications
//        let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
//
//        if SMLoginItemSetEnabled(launcherAppId as CFString, true) == false {
//            print("SMLoginItemSetEnabled: the requested change has not taken effect.")
//        }
//        print("设置自启动..")
    }
    
    var body: some Scene {
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }

}
