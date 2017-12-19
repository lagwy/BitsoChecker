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
    var currency1 : String? = "btc" {
        didSet {
            // new values for currencies variables have been set
            self.operationQueue.cancelAllOperations()
            loadCurrency()
        }
    }
    var currency2 : String? = "mxn"
    var operationQueue: OperationQueue!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        self.operationQueue = OperationQueue()
        
        //Displays text on menu bar
        item?.title = "BitsoChecker"
        
        let menu = NSMenu()
        // Defines function to run when the user clicks on the text on menu bar
        menu.addItem(NSMenuItem(title: "BTC - MXN", action: #selector(AppDelegate.btcMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "ETH - MXN", action: #selector(AppDelegate.ethMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "XRP - BTC", action: #selector(AppDelegate.xrpBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "XRP - MXN", action: #selector(AppDelegate.xrpMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "ETH - BTC", action: #selector(AppDelegate.ethBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "BCH - BTC", action: #selector(AppDelegate.bchBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quitApp), keyEquivalent: ""))
        item?.menu = menu
        
        loadCurrency()
    }
    
    func loadCurrency(){
        let stringUrl = "https://api.bitso.com/v3/ticker?book=" + (self.currency1)! + "_" + (self.currency2)!
        let url = URL(string: stringUrl )
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if (error != nil) {
                print("error")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    if ( (json["success"] as? Bool ) == true ){
                        // payload array
                        let payload = json["payload"] as? [String: Any]
                        let ask = payload?["ask"] as? String
                        let menuTitle = "1 " + (self.currency1!).uppercased() + " = " + ask! + " " + (self.currency2!).uppercased() + ""
                        self.item?.title = menuTitle as String
                        
                        // print("somethig".uppercased())
                    }
                    
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            let tempOperation = BlockOperation(block:{
                self.loadCurrency()
            })
            self.operationQueue.addOperation(tempOperation)
        })
    }
    
    func btcMxn(){
        currency1 = "btc"
        currency2 = "mxn"
    }
    
    func ethMxn(){
        currency1 = "eth"
        currency2 = "mxn"
    }
    
    func xrpBtc(){
        currency1 = "xrp"
        currency2 = "btc"
    }
    
    func xrpMxn(){
        currency1 = "xrp"
        currency2 = "mxn"
    }
    
    func ethBtc(){
        currency1 = "eth"
        currency2 = "btc"
    }
    
    func bchBtc(){
        currency1 = "bch"
        currency2 = "btc"
    }
    
    func quitApp() {
        NSApplication.shared().terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
