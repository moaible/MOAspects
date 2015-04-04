//
//  ViewController.swift
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/04/04.
//  Copyright (c) 2015年 HiromiMotodera. All rights reserved.
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
        self.greeding("Hello world")
    }
    
    // MARK: Private(Natural swift method)
    
    func greeding(greed: String) {
        NSLog(greed)
    }
    
    // MARK: Memory management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

