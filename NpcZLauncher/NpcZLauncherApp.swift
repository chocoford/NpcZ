//
//  NpcZLauncherApp.swift
//  NpcZLauncher
//
//  Created by Chocoford on 2021/4/26.
//

import SwiftUI
extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}

@main
struct NpcZLauncherApp: App {
    init () {
        let npcIdentifier = "com.chocoford.NpcZ"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == npcIdentifier }.isEmpty
        
        if !isRunning {
            let path = Bundle.main.bundlePath as NSString
            print(path)
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("NpcZ") //main app name
            
            let newURL = URL(fileURLWithPath: NSString.path(withComponents: components))
            
//            NSWorkspace.shared.launchApplication(newPath)
            let openConfiguration = NSWorkspace.OpenConfiguration()
            openConfiguration.activates = false
            openConfiguration.addsToRecentItems = false
            openConfiguration.hides = true
            
            NSWorkspace.shared.openApplication(at: newURL, configuration: openConfiguration) { app, error in
                if error != nil {
                    print("open app failed. Reason: \(error.debugDescription)")
                    DispatchQueue.main.sync {
//                        NSApp.terminate(nil)
                        exit(0)
                    }
                } else {
                    DispatchQueue.main.sync {
//                        NSApp.terminate(nil)
                        exit(0)
                    }
                }
            }
        }
        else {
            exit(0)
//            NSApp.terminate(self)
        }
        
    }
    
//    var body: Never
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
