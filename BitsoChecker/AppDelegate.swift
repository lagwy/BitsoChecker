//
//  AppDelegate.swift
//  BitsoChecker
//
//  Created by Luis Angel Martinez on 18/12/17.
//  Copyright © 2017 Luis Angel Martinez. All rights reserved.
//

import Cocoa
import Foundation

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
        menu.addItem(NSMenuItem(title: "BTC - MXN", action: #selector(AppDelegate.btcMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "ETH - MXN", action: #selector(AppDelegate.ethMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "XRP - BTC", action: #selector(AppDelegate.xrpBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "XRP - MXN", action: #selector(AppDelegate.xrpMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "ETH - BTC", action: #selector(AppDelegate.ethBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "BCH - BTC", action: #selector(AppDelegate.bchBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quitMe), keyEquivalent: ""))
        item?.menu = menu
    }
    
    func btcMxn(){
        let url = URL(string: "https://api.bitso.com/v3/ticker?book=btc_mxn")!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("error")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    if ( (json["success"] as? Bool ) == true ){
                        // payload array
                        let payload = json["payload"] as? [String: Any]
                        let ask = payload?["ask"] as? String
                        // print(ask)
                        self.item?.title = "1 BTC = " + ask! + " MXN"
                    }
                
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.btcMxn()
        })
    }
    
    func ethMxn(){
        print ("waiting")
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.ethMxn()
        })
    }
    
    func xrpBtc(){
        print ("waiting")
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.xrpBtc()
        })
    }
    
    func xrpMxn(){
        print ("waiting")
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.xrpMxn()
        })
    }
    
    func ethBtc(){
        print ("waiting")
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.ethBtc()
        })
    }
    
    func bchBtc(){
        print ("waiting")
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.bchBtc()
        })
    }
    
    func testMe() {
        item?.title = "It works"
        print ("It works!")
    }
    
    func quitMe() {
        NSApplication.shared().terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
