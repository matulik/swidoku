//
//  SettingsController.swift
//  swidoku
//
//  Created by CS_praktykant on 15/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var highlightSwitch: UISwitch!
    @IBOutlet var autoinfoSwitch: UISwitch!
    @IBOutlet var tableCollectionView: UICollectionView!
    
    var highlight : Bool = false
    var autoinfo : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.highlightSwitch.setOn(self.highlight, animated: false)
        self.autoinfoSwitch.setOn(self.autoinfo, animated: false)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let mainVC = self.navigationController?.viewControllers[0] as! ViewController
        return mainVC.table.getTablesCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
        TableCollectionViewCell
        let mainVC = self.navigationController?.viewControllers[0] as! ViewController
        cell.tableNameLabel.text = mainVC.table.getTablesNameArray()[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        var alert = UIAlertController(title: "New game", message: "Are you sure to start new game?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: { action in
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TableCollectionViewCell
            let mainVC = self.navigationController?.viewControllers[0] as! ViewController
            mainVC.newGame(cell.tableNameLabel.text!)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        /*
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TableCollectionViewCell
        let mainVC = self.navigationController?.viewControllers[0] as! ViewController
        mainVC.newGame(cell.tableNameLabel.text!)*/
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
