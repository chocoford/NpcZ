//
//  AppDelegate.swift
//  NpcZ
//
//  Created by Chocoford on 2021/4/26.
//

import Cocoa
import SwiftUI
import ServiceManagement

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    let npcCore = NpcCore()
    
//    func applicationDidFinishLaunching(_ notification: Notification) {
//
//        let view = NSHostingView(rootView: AppView().environmentObject(npcCore))
//        // Don't forget to set the frame, otherwise it won't be shown.
//        view.frame = NSRect(x: 0, y: 0, width: 200, height: 320)
//
//        let menuItem = NSMenuItem()
//        menuItem.view = view
//
//        let menu = NSMenu()
//        menu.addItem(menuItem)
//        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        self.statusItem?.menu = menu
//        self.statusItem?.button?.image = NSImage(named: NSImage.Name(npcCore.isRunning ? "menubar-on": "menubar-off"))
//
//        // FIXME: 非常不优雅的方式
//        npcCore.barButton = self.statusItem?.button
//    }
    
    func applicationWillTerminate(_ notification: Notification) {
        /// 检查是否自启动
        let autoLaunch = UserDefaults.standard.bool(forKey: "autoLaunch")
        // 这里请填写你自己的Heler BundleID
        let launcherAppId = "com.chocoford.NpcLauncher"
        
        // 开始注册/取消启动项
        if SMLoginItemSetEnabled(launcherAppId as CFString, autoLaunch) == false {
            print("SMLoginItemSetEnabled: the requested change has not taken effect.")
        }
        
    }
}

