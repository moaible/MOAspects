//
//  AppDelegate.swift
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/04/04.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Property
    
    var window: UIWindow?
    
    var navigationController: UINavigationController?
    
    // MARK: Load
    
    override class func load() {
        MOAspects.hookInstanceMethod(clazz:NSClassFromString("MOAspectsDemoSwift.ViewController"), selector:"viewDidAppear:", position:.Before) {
            NSLog("ViewController:\($0) & \($1)")
        }
        MOAspects.hookClassMethod(clazz:Greeder.self, selector:"greeding:", position:.Before) {
            NSLog("Greeder:\($0) & \($1)")
        }
    }
    
    // MARK: Application life cycle
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.navigationController = UINavigationController(rootViewController:ViewController())
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
