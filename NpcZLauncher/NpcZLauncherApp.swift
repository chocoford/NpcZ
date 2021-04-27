//
//  NpcZLauncherApp.swift
//  NpcZLauncher
//
//  Created by Chocoford on 2021/4/26.
//

import SwiftUI

@main
struct NpcZLauncherApp: App {
    init () {
        let mainAppIdentifier = "com.chocoford.NpcZ"
        let running = NSWorkspace.shared.runningApplications
        var alreadyRunning = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default()
                .addObserver(NSApp, selector: #selector(NSApplication.terminate(_:)), name: Notification.Name("terminateNpcZ"), object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("NpcZ")
            
            let newPath = NSString.path(withComponents: components)
            NSWorkspace.shared.launchApplication(newPath)
        } else {
            NSApp.terminate(self)
        }
    }
}
