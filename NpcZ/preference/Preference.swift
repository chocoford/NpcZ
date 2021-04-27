//
//  Preference.swift
//  NpcZ
//
//  Created by Chocoford on 2021/4/26.
//

import Foundation

class Preference: ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var autoLaunch: Bool {
        didSet {
            UserDefaults.standard.set(autoLaunch, forKey: "autoLaunch")
        }
    }
    
    @Published var autoUpdateChecking: Bool {
        didSet {
            UserDefaults.standard.set(autoUpdateChecking, forKey: "autoUpdateChecking")
        }
    }
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.autoLaunch = UserDefaults.standard.object(forKey: "autoLaunch") as? Bool ?? false
        self.autoUpdateChecking = UserDefaults.standard.object(forKey: "autoUpdateChecking") as? Bool ?? true
    }
}
