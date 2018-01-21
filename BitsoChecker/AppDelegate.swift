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
        menu.addItem(NSMenuItem(title: "LTC - BTC", action: #selector(AppDelegate.ltcBtc), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "LTC - MXN", action: #selector(AppDelegate.ltcMxn), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quitApp), keyEquivalent: ""))
        item?.menu = menu
        
        loadCurrency()
    }
    
    func showNotification(title : NSString, subtitle : NSString, informativeText : NSString) -> Void {
        let notification = NSUserNotification()
        notification.identifier = "unique-id"
        notification.title = title as String
        notification.subtitle = subtitle as String
        notification.informativeText = informativeText as String
        notification.soundName = NSUserNotificationDefaultSoundName
        notification.contentImage = NSImage(contentsOf: NSURL(string: "https://placehold.it/300")! as URL)
        
        // Manually display the notification
        
        let notificationCenter = NSUserNotificationCenter.default
        
        notificationCenter.deliver(notification)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter,
                                shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "es_MX")
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func loadCurrency(){
        let stringUrl = "https://api.bitso.com/v3/ticker?book=" + (self.currency1)! + "_" + (self.currency2)!
        let url = URL(string: stringUrl )
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if (error != nil) {
                let code : NSInteger = error!._code;
                
                switch (code){
                case -1004,-1005, -1006: // cannot connect to host,network connection lost, dns lookup failed
                    self.showNotification(title: "Slow internet connection.", subtitle: "",
                                          informativeText: "It seemslikethe internet connection is a little slow.");
                    break
                case -1009: // not connected to internet
                    self.showNotification(title: "No internet connection.", subtitle: "", informativeText: "You may want to close this app until you recover the network connection.");
                    break;
                default:
                    let errorString : NSString = error!.localizedDescription as NSString;
                    self.showNotification(title: "Could not get the information.", subtitle: "",
                                          informativeText: errorString)
                    break;
                }
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    if ( (json["success"] as? Bool ) == true ){
                        // payload array
                        let payload = json["payload"] as? [String: Any]
                        let ask = payload?["ask"] as? String
                        
                        let formatedAsk = self.formatCurrency(value: Double(ask!)!)
                        
                        let menuTitle = "1 " + (self.currency1!).uppercased() + " = " + formatedAsk + " " + (self.currency2!).uppercased() + ""
                        self.item?.title = menuTitle as String
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
    
    func ltcBtc(){
        currency1 = "ltc"
        currency2 = "btc"
    }
    
    func ltcMxn(){
        currency1 = "ltc"
        currency2 = "mxn"
    }
    
    func quitApp() {
        NSApplication.shared().terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
