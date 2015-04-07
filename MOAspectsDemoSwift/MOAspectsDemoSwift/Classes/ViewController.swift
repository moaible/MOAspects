//
//  ViewController.swift
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/04/04.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Greeder.greeding("Hello world")
    }
    
    // MARK: Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class Greeder: NSObject {
    
}

extension Greeder {
    class func greeding(greed: String) {
        
    }
}

