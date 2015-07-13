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
        // Gesture
        self.initLabels()
        //
        
        //var table : Table = Table()
        //self.fillArray(table)
        
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
        //println("get: x=\(sindex), y=\(bindex)")
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
        //println("set: x=\(sindex), y=\(bindex)")
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
    
    // Filling array by param @table array
    func fillArray(table : Table) {
        for x in 0..<9 {
            for y in 0..<9 {
                self.setXYViewValue(x, y: y, v: table.getXYValue(x, y: y))
            }
        }
    }
    
    // Method to return array (for Model actions)
    func returnAsArray() -> Array<Array<Int>> {
        var table = Array<Array<Int>>()
        for i in 0..<9 {
            table.append(Array(count: 9, repeatedValue: Int()))
        }
        for x in 0..<9 {
            for y in 0..<9 {
                table[x][y] = self.getXYViewValue(x, y: y)
            }
        }
        return table
    }
    
    // Method to init labels as gesturable 
    func initLabels() {
        var labelTapArray = Array<Array<UITapGestureRecognizer>>()
        var labelArray = Array<Array<UILabel>>()
        for i in 0..<9 {
            labelTapArray.append(Array(count: 9, repeatedValue: UITapGestureRecognizer()))
            labelArray.append(Array(count: 9, repeatedValue: UILabel()))
        }
        
        var sindex : Int = -1
        var bindex : Int = -1
        
        for x in 0..<9 {
            for y in 0..<9 {
                if(x == 0 && y == 0) {
                    sindex = 99
                    bindex = 100
                }
                else {
                    bindex = (x*10)+y
                    sindex = (x+1/3)*10+(y+1/3)
                }
                labelArray[x][y] = (self.contentView.viewWithTag(sindex)?.viewWithTag(bindex) as? UILabel)!
                labelTapArray[x][y] = UITapGestureRecognizer(target: self, action: "labelTap:")
                labelTapArray[x][y].numberOfTapsRequired = 1
                labelArray[x][y].userInteractionEnabled = true
                labelArray[x][y].addGestureRecognizer(labelTapArray[x][y])
                
            }
        }
        
        
        /*
        var labelTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "labelTap")
        labelTap.numberOfTapsRequired = 1
        
        var sindex : Int = -1
        var bindex : Int = -1
        
        for x in 0..<6 {
            for y in 0..<6 {
                if (x == 0 && y == 0) {
                    sindex = 99
                    bindex = 100
                }
                else {
                    bindex = (x*10)+y
                    sindex = (x+1/3)*10+(y+1/3)
                }
                var label : UILabel? = self.contentView.viewWithTag(sindex)?.viewWithTag(bindex) as? UILabel
                label?.userInteractionEnabled = true
                label?.addGestureRecognizer(labelTap)
            }
        }*/
    }
    
    // Perform tap
    func labelTap(g: UIGestureRecognizer) {
        var view = g.view
        println(view!.tag)
    }
}
