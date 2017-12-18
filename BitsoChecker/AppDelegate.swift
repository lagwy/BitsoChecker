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
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        
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
        let url = URL(string: "https://api.bitso.com/v3/ticker?book=eth_mxn")!
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
                        self.item?.title = "1 ETH = " + ask! + " MXN"
                    }
                    
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.ethMxn()
        })
    }
    
    func xrpBtc(){
        let url = URL(string: "https://api.bitso.com/v3/ticker?book=xrp_btc")!
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
                        self.item?.title = "1 XRP = " + ask! + " BTC"
                    }
                    
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.xrpBtc()
        })
    }
    
    func xrpMxn(){
        let url = URL(string: "https://api.bitso.com/v3/ticker?book=xrp_mxn")!
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
                        self.item?.title = "1 XRP = " + ask! + " MXN"
                    }
                    
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.xrpMxn()
        })
    }
    
    func ethBtc(){
        let url = URL(string: "https://api.bitso.com/v3/ticker?book=eth_btc")!
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
                        self.item?.title = "1 ETH = " + ask! + " BTC"
                    }
                    
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.ethBtc()
        })
    }
    
    func bchBtc(){
        let url = URL(string: "https://api.bitso.com/v3/ticker?book=bch_btc")!
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
                        self.item?.title = "1 BCH = " + ask! + " BTC"
                    }
                    
                    
                } catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        // wait a minute and call again
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {
            self.bchBtc()
        })
    }
    
    func quitApp() {
        NSApplication.shared().terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
