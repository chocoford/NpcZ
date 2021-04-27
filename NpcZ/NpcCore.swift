//
//  NPCCore.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/22.
//

import Foundation
import Cocoa

let LAUNCH_AGENT_NAME = "chocoford.npcz.npc-core"
let AppResourcesPath = Bundle.main.bundlePath + "/Contents/Resources"
//let AppHomePath = AppResourcesPath + "/.NpcZ"

let npcCorePath = AppResourcesPath
let npcCoreFile = npcCorePath + "/npc"

let logFilePath = AppResourcesPath + "/Library/Logs/npc.log"
let configFilePath = npcCorePath + "/npc.conf"


class NpcCore: ObservableObject {
    var task: Process?
    @Published var isRunning: Bool = false
    @Published var infoLog: String = ""
    @Published var npcLog: String = ""
    var barButton: NSStatusBarButton?
    
    
    init() {}
    
    
    func start() {
        self.infoLog = ""
        do {
            self.task = try Process.run(URL(fileURLWithPath: npcCoreFile), arguments: ["-config", configFilePath]) { task in
                if task.terminationStatus == 0 {
                    print("Stop npc-core succeeeded")
                    DispatchQueue.main.async {
                        self.isRunning.toggle()
                        self.infoLog = ""
                        self.barButton?.image = NSImage(named: "menubar-off")
                    }
                } else {
                    print("error in running npc-core, terminationStatus: ", task.terminationStatus)
                    DispatchQueue.main.async {
                        self.isRunning.toggle()
                        self.infoLog = "启动失败，请检查配置"
                        self.barButton?.image = NSImage(named: "menubar-off")
                    }
                }
            }
            isRunning.toggle()
            self.barButton?.image = NSImage(named: "menubar-on")
        } catch let error {
            print("Start npc-core failed: \(error)")
            isRunning = false
            self.barButton?.image = NSImage(named: "menubar-off")
        }
    }

    func stop() {
        guard let task = self.task else { return }
        task.terminate()
    }

    
    
    
    @available(*, deprecated, message: "暂时用不上")
    static func OpenLogs() {
        if !FileManager.default.fileExists(atPath: logFilePath) {
            let txt = ""
            try! txt.write(to: URL.init(fileURLWithPath: logFilePath), atomically: true, encoding: String.Encoding.utf8)
        }

        let task = Process.launchedProcess(launchPath: "/usr/bin/open", arguments: [logFilePath])
        task.waitUntilExit()
        if task.terminationStatus == 0 {
            NSLog("open logs succeeded.")
        } else {
            NSLog("open logs failed.")
        }
    }
    
    @available(*, deprecated, message: "暂时用不上")
    static func ClearLogs() {
        let txt = ""
        try! txt.write(to: URL.init(fileURLWithPath: logFilePath), atomically: true, encoding: String.Encoding.utf8)
    }
    
    @available(*, deprecated, message: "暂时用不上")
    static func install() {
        NpcCore.generateLaunchAgentPlist()
    }
    
    @available(*, deprecated, message: "暂时用不上")
    static func generateLaunchAgentPlist() {
        let launchAgentDirPath = NSHomeDirectory() + "/Library/LaunchAgents/"
        let launchAgentPlistFile = launchAgentDirPath + LAUNCH_AGENT_NAME + ".plist"

        // Ensure launch agent directory is existed.
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: launchAgentDirPath) {
            try! fileMgr.createDirectory(atPath: launchAgentDirPath, withIntermediateDirectories: true, attributes: nil)
        }

        // write launch agent
        let agentArguments = [npcCoreFile, "-config", "\(npcCorePath)/npc.conf"]

        let dictAgent: NSMutableDictionary = [
            "Label": LAUNCH_AGENT_NAME,
//            "WorkingDirectory": AppHomePath,
            "StandardOutPath": logFilePath,
            "StandardErrorPath": logFilePath,
            "ProgramArguments": agentArguments,
            "KeepAlive": false,
        ]

        dictAgent.write(toFile: launchAgentPlistFile, atomically: true)
        // load launch service
        Process.launchedProcess(launchPath: "/bin/launchctl", arguments: ["remove", LAUNCH_AGENT_NAME])
        Process.launchedProcess(launchPath: "/bin/launchctl", arguments: ["load", "-wF", launchAgentPlistFile])
    }
    
    @available(*, deprecated, message: "暂时用不上")
    static func Start() {
        do {
            _ = try shell(URL(fileURLWithPath: "/bin/launchctl"), arguments: ["stop", LAUNCH_AGENT_NAME])
            try Process.run(URL(fileURLWithPath: "/bin/launchctl"), arguments: ["start", LAUNCH_AGENT_NAME]) { task in
                print("task.terminationStatus: ", task.terminationStatus)
                if task.terminationStatus == 0 {
                    NSLog("Start npc-core succeeded.")
                } else {
                    NSLog("Start npc-core failed.")
                }
            }
        }
        catch let error {
            print(error)
        }
    }
    
    @available(*, deprecated, message: "暂时用不上")
    static func Stop() {
        let task = Process.launchedProcess(launchPath: "/bin/launchctl", arguments: ["stop", LAUNCH_AGENT_NAME])
        task.waitUntilExit()
        if task.terminationStatus == 0 {
            NSLog("Stop npc-core succeeded.")
        } else {
            NSLog("Stop npc-core failed.")
        }
    }
}

