//
//  SettingsController.swift
//  swidoku
//
//  Created by CS_praktykant on 15/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {//, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var highlightSwitch: UISwitch!
    @IBOutlet var autoinfoSwitch: UISwitch!
    
    var highlight : Bool = false
    var autoinfo : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.highlightSwitch.setOn(self.highlight, animated: false)
        self.autoinfoSwitch.setOn(self.autoinfo, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    @IBAction func highlightValueChanged(sender: AnyObject) {
        if self.highlight == false {
            self.highlight = true
        }
        else {
            self.highlight = false
        }
        self.passData()
    }
    
    @IBAction func autoinfoValueChanged(sender: AnyObject) {
        if self.autoinfo == false {
            self.autoinfo = true
        }
        else {
            self.autoinfo = false
        }
        self.passData()
    }
    
    // Passing by casting from navigationController stack
    func passData() {
        let mainVC = self.navigationController?.viewControllers[0] as! ViewController
        mainVC.highlight = self.highlight
        mainVC.autoinfo = self.autoinfo
        mainVC.clearHighlight()
    }
    
    // It doesnt work for navigation controller "back"
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }*/
}
