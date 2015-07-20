//
//  ViewController.swift
//  swidoku
//
//  Created by CS_praktykant on 10/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

var firstRun = true

class ViewController: UIViewController {
    @IBOutlet var contentView: UIView!
    
    var currentSelectedTag : Int = 88
    var currentSelectedX : Int = 8
    var currentSelectedY : Int = 8
    var currentTagEditable : Bool = false
    var highlight : Bool = false
    var autoinfo : Bool = false
    var currentTableName : String = ""
    var blurView : UIVisualEffectView = UIVisualEffectView()
    @IBOutlet var newGameButtom: UIBarButtonItem!
    
    var table : Table = Table()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Gesture (must to do)
        self.initLabels()
        //
        if(firstRun) {
            self.performSegueWithIdentifier("newgame", sender: self)
            firstRun = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*deinit {
        println("deinit")
    }*/
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settings" {
            let settingsVC = segue.destinationViewController as! SettingsController
            settingsVC.highlight = self.highlight
            settingsVC.autoinfo = self.autoinfo
        }
        else if segue.identifier == "newgame" {
            let sourVC = segue.sourceViewController as! ViewController
            let destVC = segue.destinationViewController as! NewGameController
            destVC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
            var destView = destVC.view
            destView.backgroundColor = UIColor.clearColor()
            self.setBlur()
        }
    }
    
    @IBAction func checkButton(sender: AnyObject) {
        self.runCheck()
    }
    
    // Buttons actions
    @IBAction func pressButton1(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 1)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton2(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 2)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton3(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 3)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton4(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 4)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton5(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 5)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton6(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 6)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton7(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 7)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton8(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 8)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButton9(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 9)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    @IBAction func pressButtonClear(sender: AnyObject) {
        if self.currentTagEditable == true {
            self.setXYViewValue(self.currentSelectedX, y: self.currentSelectedY, v: 0)
            self.table.setArray(self.returnAsArray())
        }
    }
    
    // Load new table
    func newGame(tableName : String) {
        self.currentTagEditable = false
        self.table.readJSONTableFromFile(tableName)
        self.initLabels()
        self.fillArray(self.table)
        var label : UILabel? = self.contentView.viewWithTag(self.currentSelectedTag) as? UILabel
        if let l = label {
            l.backgroundColor = UIColor(red: 0xFF/255, green: 0xCC/255, blue: 0x66/255, alpha: 1.0)
        }
        self.clearHighlight()
        self.currentTableName = tableName
        self.table.currentTableName = self.currentTableName
        println("new game: \(tableName)")
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
            if (l.text! == "0" || l.text! == "") {
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
    // Remember to call only once in initialization of table
    func fillArray(table : Table) {
        var bindex : Int = 0
        for x in 0..<9 {
            for y in 0..<9 {
                if (table.getXYValue(x, y: y) != 0) {
                    if (x == 0 && y == 0) {
                        bindex = 100
                    }
                    else {
                        bindex = x*10+y
                    }
                    var label : UILabel? = self.contentView.viewWithTag(bindex) as? UILabel
                    if let l = label {
                        l.textColor = UIColor(red: 0xFF/255, green: 0xFF/255, blue: 0xFF/255, alpha: 1.0)
                        l.enabled = false
                    }
                    self.setXYViewValue(x, y: y, v: table.getXYValue(x, y: y))
                }
                else {
                    self.setXYViewValue(x, y: y, v: table.getXYValue(x, y: y))
                }
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
                labelArray[x][y].text = ""
                labelArray[x][y].addGestureRecognizer(labelTapArray[x][y])
                labelArray[x][y].enabled = true
            }
        }
    }
    
    // Perform tap
    func labelTap(g: UIGestureRecognizer) {
        var view = g.view
        if (self.currentSelectedTag != view?.tag) {
            // Previous label # TO REMOVE - drawHighligh can do it
            var label_prev : UILabel? = self.contentView.viewWithTag(self.currentSelectedTag) as? UILabel
            label_prev!.backgroundColor = UIColor(red: 0xFF/255, green: 0xCC/255, blue: 0x66/255, alpha: 1.0)
            //
            
            // Current label
            self.currentSelectedTag = view!.tag
            self.currentSelectedX = self.currentSelectedTag / 10
            self.currentSelectedY = self.currentSelectedTag - self.currentSelectedX * 10
            self.drawHighligh()
            var label : UILabel? = self.contentView.viewWithTag(view!.tag) as? UILabel
            label!.backgroundColor = UIColor(red: 0xFF/255, green: 0xFF/255, blue: 0x00/255, alpha: 1.0)
            
            // Disable editable
            self.currentTagEditable = false
        }
        else {
            var label_prev : UILabel? = self.contentView.viewWithTag(self.currentSelectedTag) as? UILabel
            if let l = label_prev {
                if (l.enabled == false) {
                    return
                }
                l.backgroundColor = UIColor(red: 0x00/255, green: 0xC8/255, blue: 0xFF/255, alpha: 1.0)
                self.currentTagEditable = true
            }
        }
        if (self.table.checkTable() == true && self.autoinfo) {
            self.runCheck()
        }
    }
    
    func drawHighligh() {
        if self.highlight == false {
            return
        }
        else {
            // Clear
            var bsindex : Int = -1
            for x in 0..<9 {
                for y in 0..<9 {
                    if(x == 0 && y == 0){
                        bsindex = 100
                    }
                    else {
                        bsindex = (x*10)+y
                    }
                    var label = self.contentView.viewWithTag(bsindex) as? UILabel
                    if let l = label {
                        label!.backgroundColor = UIColor(red: 0xFF/255, green: 0xCC/255, blue: 0x66/255, alpha: 1.0)
                    }
                }
            }
            // Draw x
            bsindex = -1
            for i in 0..<9 {
                if (self.currentSelectedX == 0 && i == 0){
                    bsindex = 100
                }
                else {
                    bsindex = (self.currentSelectedX*10)+i
                }
                var label = self.contentView.viewWithTag(bsindex) as? UILabel
                if let l = label {
                    label!.backgroundColor = UIColor(red: 0x00/255, green: 0xCC/255, blue: 0x00/255, alpha: 1.0)
                }
            }
            // Draw y
            for i in 0..<9 {
                if(self.currentSelectedY == 0 && i == 0){
                    bsindex = 100
                }
                else {
                    bsindex = (i*10)+self.currentSelectedY
                }
                var label = self.contentView.viewWithTag(bsindex) as? UILabel
                if let l = label {
                    label!.backgroundColor = UIColor(red: 0x00/255, green: 0xCC/255, blue: 0x00/255, alpha: 1.0)
                }
            }
            // Draw square
            let tag = ((self.currentSelectedTag/10)/3)*10+((self.currentSelectedTag-(self.currentSelectedTag/10)*10)/3)
            let x : Int = (tag/10)*3
            let y : Int = (tag - (tag/10)*10)*3
            for n in x..<x+3 {
                for m in y..<y+3 {
                    if (n == 0 && m == 0) {
                        bsindex = 100
                    }
                    else
                    {
                        bsindex = (n*10)+m
                    }
                    var label = self.contentView.viewWithTag(bsindex) as? UILabel
                    if let l = label {
                        label!.backgroundColor = UIColor(red: 0x00/255, green: 0xCC/255, blue: 0x00/255, alpha: 1.0)
                    }
                }
            }
        }
    }
    
    func clearHighlight() {
        var bindex : Int
        for x in 0..<9 {
            for y in 0..<9 {
                if(x == 0 && y == 0) {
                    bindex = 100
                }
                else {
                    bindex = (x*10)+y
                }
                var label = self.contentView.viewWithTag(bindex) as? UILabel
                if let l = label {
                    label!.backgroundColor = UIColor(red: 0xFF/255, green: 0xCC/255, blue: 0x66/255, alpha: 1.0)
                }
            }
        }
    }
    
    func runCheck() {
        var message : String
        var title : String
        if (self.table.checkTable() == true) {
            title = "Success!"
            message = "Your table is perfectly!"
        }
        else {
            title = "Checking fail.."
            message = "Your table is wrong.."
        }
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func setBlur(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        var blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurView = UIVisualEffectView(effect: blur)
        self.blurView.frame = self.view.bounds
        
        UIView.transitionWithView(self.view, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            self.view.addSubview(self.blurView)
            }, completion: nil)
    }
    
    func removeBlur() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        UIView.transitionWithView(self.view, duration: 3.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            self.blurView.removeFromSuperview()
            }, completion: nil)
    }
}



