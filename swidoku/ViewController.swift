//
//  ViewController.swift
//  swidoku
//
//  Created by CS_praktykant on 10/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var sq00View: UIView!
    @IBOutlet var sq01View: UIView!
    @IBOutlet var sq02View: UIView!
    @IBOutlet var sq10View: UIView!
    @IBOutlet var sq11View: UIView!
    @IBOutlet var sq12Vuew: UIView!
    @IBOutlet var sq20View: UIView!
    @IBOutlet var sq21View: UIView!
    @IBOutlet var sq22View: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getXYViewValue(x: Int, y: Int) -> Int {
        var label00 : UILabel = self.sq00View.viewWithTag(0)
    }
}

