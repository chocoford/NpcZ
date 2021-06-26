//
//  GeneralSettingsView.swift
//  NpcZ
//
//  Created by Chocoford on 2021/4/26.
//

import SwiftUI
import ServiceManagement
import Sparkle

struct GeneralSettingsView: View {
    
    @AppStorage("autoLaunch") private var autoLaunch = false
    @AppStorage("autoUpdateChecking") private var autoUpdateChecking = false

    let updater = SUUpdater()
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Toggle("开机自启动", isOn: $autoLaunch)
                Toggle("自动检查更新", isOn: $autoUpdateChecking).disabled(true)
//                Picker(selection: .constant(1), label: Text("显示方式")) {
//                    Text("状态栏").tag(1)
//                    Text("程序坞").tag(2)
//                }
//
            }.padding(.vertical, 20)
            
//            Divider()
            
            HStack {
                Button("检查更新") {
                    updater.checkForUpdateInformation()
                }
                Button("提交反馈") {
                    
                }.disabled(true)
            }
        }
        .padding()
    }
    
    func toggleDock(show: Bool) -> Bool {
        // ProcessApplicationTransformState
        let transformState = show ?
        // show to foreground application or not show to background application
            ProcessApplicationTransformState(kProcessTransformToForegroundApplication)
        : ProcessApplicationTransformState(kProcessTransformToUIElementApplication)

        // transform current application type.
        var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kCurrentProcess))
        return TransformProcessType(&psn, transformState) == 0
    }
    func toggleDock2(show: Bool) -> Bool {
        return show ?
            NSApp.setActivationPolicy(.regular)
            : NSApp.setActivationPolicy(.accessory)
    }
    
    
    
    func startupAppWhenLogin(startup: Bool) {
        // 这里请填写你自己的Heler BundleID
        let launcherAppId = "com.chocoford.NpcLauncher"
        
        // 开始注册/取消启动项
        if SMLoginItemSetEnabled(launcherAppId as CFString, startup) == false {
            print("SMLoginItemSetEnabled: the requested change has not taken effect.")
        }

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
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
