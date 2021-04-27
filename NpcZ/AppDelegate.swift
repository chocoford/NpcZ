//
//  AppDelegate.swift
//  NpcZ
//
//  Created by Chocoford on 2021/4/26.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

    let npcCore = NpcCore()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let view = NSHostingView(rootView: AppView().environmentObject(npcCore))
        // Don't forget to set the frame, otherwise it won't be shown.
        view.frame = NSRect(x: 0, y: 0, width: 200, height: 320)
        
        let menuItem = NSMenuItem()
        menuItem.view = view
        
        let menu = NSMenu()
        menu.addItem(menuItem)
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem?.menu = menu
        self.statusItem?.button?.image = NSImage(named: NSImage.Name(npcCore.isRunning ? "menubar-on": "menubar-off"))
        
        // FIXME: 非常不优雅的方式
        npcCore.barButton = self.statusItem?.button
    }
}

