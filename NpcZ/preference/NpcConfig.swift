//
//  NpcConfig.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/24.
//

import Foundation

class NpcConfig: ObservableObject {
//    let serverPort = 8024
//    @Published var serverAdress: String = ""
//    @Published var openedPort: [String] = []
//    @Published var vkey: String = ""
//
//    static var serverAdress: String {
//        return UserDefaults.standard.string(forKey: "serverAdress") ?? ""
//    }
//    static var vkey: String {
//        return UserDefaults.standard.string(forKey: "vkey") ?? ""
//    }
//
//    init() {
//        /// 读取配置
//        let confFilePath = URL.init(fileURLWithPath: configFilePath)
//        print(configFilePath)
//        do {
//            let configText = try String(contentsOf: confFilePath, encoding: .utf8)
//            let lines = configText.split(separator: "\n")
//            if lines.count == 5 {
//                serverAdress = String((lines[1].split(separator: "=").last ?? "").split(separator: ":").first ?? "")
//                vkey = String(lines[3].split(separator: "=").last ?? "")
//            } else {
//                resetProperties()
//            }
//        } catch let error {
//            print("读取配置文件失败，将生成默认配置文件。", error)
//            resetProperties()
//        }
//    }
//
//    func resetProperties() {
//        serverAdress = "127.0.0.1"
//        vkey = "123"
//        let out = createConfFile()
//        print(out)
//    }
//
    // create npc.conf
    static func createConfFile() -> String {
        let serverPort = 8024

        let serverAdress: String = UserDefaults.standard.string(forKey: "serverAdress") ?? ""
        let vkey: String = UserDefaults.standard.string(forKey: "vkey") ?? ""
        let p2pPassword: String = UserDefaults.standard.string(forKey: "p2pPassword") ?? ""
        let configText: String =
            """
            [common]
            server_addr=\(serverAdress):\(serverPort)
            conn_type=tcp
            vkey=\(vkey)
            disconnect_timeout=60
            [p2p_ssh]
            mode=p2p
            password=ssh2
            target_addr=10.1.50.2:22
            """

        do {
            let confFilePath = URL.init(fileURLWithPath: configFilePath)

            // delete before config
            if FileManager.default.fileExists(atPath: configFilePath) {
                try? FileManager.default.removeItem(at: confFilePath)
            }

            try configText.write(to: confFilePath, atomically: true, encoding: String.Encoding.utf8)
            print(confFilePath)
        } catch let error {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            NSLog("save conf file fail: \(error)")
            return "保存失败"
        }
        return "保存成功"
    }
}
