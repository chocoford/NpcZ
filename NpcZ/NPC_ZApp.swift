//
//  NPC_ZApp.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/20.
//

import SwiftUI

var appVersion: String { return "\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] ?? "" )" }

enum AppState: String {
    case started
    case stopped
}

@main
struct NPC_ZApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isRunning: Bool = false

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
    }
    
    var body: some Scene {
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
    
//    func startupAppWhenLogin(startup: Bool) {
//        // 这里请填写你自己的Heler BundleID
//        let launcherAppIdentifier = "com.chocoford.NpcZ.NpcZHelper"
//        
//        // 开始注册/取消启动项
//        SMLoginItemSetEnabled(launcherAppIdentifier,startup)
//        
//        var startedAtLogin = false
//        for app in NSWorkspace.sharedWorkspace().runningApplications {
//            if app.bundleIdentifier == launcherAppIdentifier {
//                startedAtLogin = true
//            }
//        }
//        
//        if startedAtLogin {
//            NSDistributedNotificationCenter.defaultCenter().postNotificationName("killhelper",object: NSBundle.mainBundle().bundleIdentifier!)
//        }
//    }
}
