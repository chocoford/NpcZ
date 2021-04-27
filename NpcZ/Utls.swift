//
//  Utls.swift
//  NPC-Z
//
//  Created by Chocoford on 2021/4/21.
//

import Foundation

//func shell(launchPath: String = "/usr/bin/env", args: String) -> Process {
//    let task = Process()
//    task.launchPath = launchPath
//    task.arguments = ["bash", "-c", args]
//    task.currentDirectoryURL = URL(fileURLWithPath: NSHomeDirectory())
//    print("excute shell command: bash -c \(args)")
//    task.launch()
////    task.waitUntilExit()
//    return task
//}
//


func shell(_ executableURL: URL = URL(fileURLWithPath: "/usr/bin/env"), arguments: [String], terminationHandler: ((Process) -> Void)? = nil) throws -> Process {
    let pipe = Pipe()
    let task = Process()
    task.executableURL = executableURL
    task.arguments = arguments
    task.terminationHandler = terminationHandler
    
    task.standardOutput = pipe
    try task.run()

//    let data = pipe.fileHandleForReading.availableData
//    let output = String(data: data, encoding: String.Encoding.utf8)!
//
//    if output.count > 0 {
//        //remove newline character.
//        let lastIndex = output.index(before: output.endIndex)
//        return String(output[output.startIndex..<lastIndex])
//    }

    return task//"output"
}
