//
//  AppMenu.swift
//  AudioHotkeys
//
//  Created by test on 29.01.21.
//  Copyright © 2021 Emanuel Mairoll. All rights reserved.
//

import Cocoa

class AppMenu: NSMenu {
    let parent: NSStatusItem!

    let controller: MenuController

    init(parent: NSStatusItem) {
        self.parent = parent
        self.controller = MenuController()

        super.init(title: "")

        initMenu()

        parent.button?.title = "   "

        controller.setSymbolHandler { symbols in
            let reduced = symbols.reduce("") { a, b in
                a == "" ? b : a + " " + b
            }
            
            parent.button?.title = reduced
        }
    }
        
    required init(coder: NSCoder) {
        abort()
    }
    
    func initMenu(){
        let editItem = NSMenuItem()
        editItem.title = "Edit Config"
        editItem.target = self
        editItem.action = #selector(self.editConfigClicked)
        self.addItem(editItem)

        let quitItem = NSMenuItem()
        quitItem.title = "Quit"
        quitItem.target = self
        quitItem.action = #selector(self.quitClicked)
        self.addItem(quitItem)
    }

    func defaultsFile() -> URL?{
        let path: [AnyObject] = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [AnyObject]
        guard let folder = path[0] as? String else { return nil }
        return URL(string: folder)
    }

    @IBAction func editConfigClicked(sender: NSMenuItem) {
        openConfigFileAndQuit()
    }

    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
