//
//  AppDelegate.swift
//  iOS Example
//
//  Created by Marko Tadic on 1/31/16.
//  Copyright © 2016 AE. All rights reserved.
//

import UIKit
import AEAppVersionManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        AEAppVersionManager.sharedInstance.initialize()
        
        return true
    }

}
