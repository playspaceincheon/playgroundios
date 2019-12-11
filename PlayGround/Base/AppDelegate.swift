//
//  AppDelegate.swift
//  PlayGround
//
//  Created by kim jason on 22/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import XCGLogger
import SwiftyJSON
import UserNotifications
import SnapKit
import SwiftEventBus
import GoogleSignIn

var log: XCGLogger? = nil

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        log = XCGLogger.default
        //DEBUG 일경우
        log?.debug("debug mode")
        log?.logAppDetails()
        log?.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)

        
        GMSServices.provideAPIKey(googleMAPKey)
        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configMainViewInterface(in: window)
        self.window = window
        return true
    }
    
}

