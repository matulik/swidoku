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
    
    var currentSelectedTag : Int = 88
    var currentSelectedX : Int = 8
    var currentSelectedY : Int = 8
    var currentTagEditable : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Gesture
        self.initLabels()
        //
        
        var table : Table = Table()
        self.fillArray(table)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Buttons actions
    @IBAction func pressButton1(sender: AnyObject) {
        if self.currentTagEditable == true {
        self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 1)
        }
    }
    
    @IBAction func pressButton2(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 2)
        }
    }
    
    @IBAction func pressButton3(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 3)
        }
    }
    
    @IBAction func pressButton4(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 4)
        }
    }
    
    @IBAction func pressButton5(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 5)
        }
    }
    
    @IBAction func pressButton6(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 6)
        }
    }
    
    @IBAction func pressButton7(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 7)
        }
    }
    
    @IBAction func pressButton8(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 8)
        }
    }
    
    @IBAction func pressButton9(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 9)
        }
    }
    
    @IBAction func pressButtonClear(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 0)
        }
    }
    
    // Method to get XY value from view
    func getXYViewValue(x: Int, y: Int) -> Int {
        // Index for 9x9
        var bindex : Int = -1
        if (x == 0 && y == 0) {
            bindex = 100
        }
        else {
            bindex = (x*10)+y
        }
        // Getting value
        //println("get: x=\(sindex), y=\(bindex)")
        var label : UILabel? = self.contentView.viewWithTag(bindex) as? UILabel
        if let l = label {
            if l.text! == "0" {
                return 0
            }
            else {
                return l.text!.toInt()!
            }
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
        // Index for 9x9
        var bindex : Int = -1
        if (x == 0 && y == 0) {
            bindex = 100
        }
        else {
            bindex = (x*10)+y
        }
        // Setting value
        //println("set: x=\(sindex), y=\(bindex)")
        var label : UILabel? = self.contentView.viewWithTag(bindex) as? UILabel
        if let l = label {
            if v == 0 {
                l.text = ""
            }
            else {
                l.text = String(format: "%d", v)
            }
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
        
        var bindex : Int = -1
        
        for x in 0..<9 {
            for y in 0..<9 {
                if(x == 0 && y == 0) {
                    bindex = 100
                }
                else {
                    bindex = (x*10)+y
                }
                labelArray[x][y] = (self.contentView.viewWithTag(bindex) as? UILabel)!
                labelTapArray[x][y] = UITapGestureRecognizer(target: self, action: "labelTap:")
                labelTapArray[x][y].numberOfTapsRequired = 1
                labelArray[x][y].userInteractionEnabled = true
                labelArray[x][y].addGestureRecognizer(labelTapArray[x][y])
            }
        }
    }
    
    // Perform tap
    func labelTap(g: UIGestureRecognizer) {
        var view = g.view
        if (self.currentSelectedTag != view?.tag) {
            // Previous label
            var label_prev : UILabel? = self.contentView.viewWithTag(self.currentSelectedTag) as? UILabel
            label_prev!.backgroundColor = UIColor(red: 0xFF/255, green: 0xCC/255, blue: 0x66/255, alpha: 1.0)
            
            // Current label
            self.currentSelectedTag = view!.tag
            self.currentSelectedX = self.currentSelectedTag / 10
            self.currentSelectedY = self.currentSelectedTag - self.currentSelectedX * 10
            var label : UILabel? = self.contentView.viewWithTag(view!.tag) as? UILabel
            label!.backgroundColor = UIColor(red: 0xFF/255, green: 0xFF/255, blue: 0x00/255, alpha: 1.0)
            
            // Disable editable
            self.currentTagEditable = false
        }
        else {
            var label_prev : UILabel? = self.contentView.viewWithTag(self.currentSelectedTag) as? UILabel
            label_prev!.backgroundColor = UIColor(red: 0x00/255, green: 0xC8/255, blue: 0xFF/255, alpha: 1.0)
            self.currentTagEditable = true
        }
    }

}