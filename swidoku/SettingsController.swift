//
//  SettingsController.swift
//  swidoku
//
//  Created by CS_praktykant on 15/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    var highlight : Bool
    var autoInfo : Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("asd")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Switcher for Highlight fields
    @IBAction func switchHighlight(sender: AnyObject) {
        let mainVC = ViewController
    }
    
    @IBAction func switchAutoInfo(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // TODO
    }
}
