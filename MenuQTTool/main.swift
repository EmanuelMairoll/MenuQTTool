//
//  main.swift
//  AudioHotkeys
//
//  Created by test on 29.01.21.
//  Copyright © 2021 Emanuel Mairoll. All rights reserved.
//

import Foundation
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
}

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate

let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
statusBarItem.menu = AppMenu(parent: statusBarItem)

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)


