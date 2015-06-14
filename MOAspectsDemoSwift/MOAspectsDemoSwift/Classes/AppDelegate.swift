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
    
    // MARK: Application life cycle
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        MOAspects.hookInstanceMethodForClass(ViewController.self, selector:"viewDidLoad", position:.Before) {
            (t:AnyObject!)->Void in
            NSLog("t is \(t)")
        }
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.navigationController = UINavigationController(rootViewController:ViewController())
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
