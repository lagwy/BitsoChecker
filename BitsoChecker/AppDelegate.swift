//
//  AppDelegate.swift
//  BitsoChecker
//
//  Created by Luis Angel Martinez on 18/12/17.
//  Copyright © 2017 Luis Angel Martinez. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    var item : NSStatusItem? = nil
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        
        //Displays text on menu bar
        item?.title = "TestMe"
        
        // Defines function to run when the user clicks on the text on menu bar
        //item?.action = #selector(AppDelegate.testMe)
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Option 1", action: #selector(AppDelegate.testMe), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quitMe), keyEquivalent: ""))
        item?.menu = menu
    }
    
    func testMe() {
        print ("It works!")
    }
    
    func quitMe() {
        NSApplication.shared().terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
