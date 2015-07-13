//
//  ViewController.swift
//  swidoku
//
//  Created by CS_praktykant on 10/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Method to get XY value from view
    func getXYViewValue(x: Int, y: Int) -> Int {
        // Index for 3x3
        var sindex : Int = -1
        // Index for 9x9
        var bindex : Int = -1
        if (x == 0 && y == 0) {
            sindex = 99
            bindex = 100
        }
        else {
            bindex = (x*10)+y
            sindex = (x+1/3)*10+(y+1/3)
        }
        // Getting value
        println("get: x=\(sindex), y=\(bindex)")
        var label : UILabel? = self.contentView.viewWithTag(sindex)?.viewWithTag(bindex) as? UILabel
        if let l = label {
            return l.text!.toInt()!
        }
        // Bad x or y = -1
        else {
            return -1
        }
    }
    
    // Method to setting value in view
    func setXYViewValue(x: Int, y: Int, v: Int) -> Int {
        // Bad value = -2
        if (v < 0 || v > 9) {
            return -2
        }
        // Index for 3x3
        var sindex : Int = -1
        // Index for 9x9
        var bindex : Int = -1
        if (x == 0 && y == 0) {
            sindex = 99
            bindex = 100
        }
        else {
            bindex = (x*10)+y
            sindex = (x+1/3)*10+(y+1/3)
        }
        // Setting value
        println("set: x=\(sindex), y=\(bindex)")
        var label : UILabel? = self.contentView.viewWithTag(sindex)?.viewWithTag(bindex) as? UILabel
        if let l = label {
            l.text = String(format: "%d", v)
            // Return 0 if success
            return 0
        }
            // Bad x or y = -1
        else {
            return -1
        }
    }
}
