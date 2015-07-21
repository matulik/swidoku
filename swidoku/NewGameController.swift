//
//  NewGameController.swift
//  swidoku
//
//  Created by CS_praktykant on 17/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import UIKit

class NewGameController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelNewGame(sender: AnyObject) {
        self.returnToMainVC()
    }
    
    func returnToMainVC() {
        let navC = self.presentingViewController as! UINavigationController
        let mainVC = navC.topViewController as! ViewController
        mainVC.removeBlur(2.0)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    // DataSources
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let navC = self.presentingViewController as! UINavigationController
        let mainVC = navC.topViewController as! ViewController
        return mainVC.table.getTablesCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
        TableCollectionViewCell
        let navC = self.presentingViewController as! UINavigationController
        let mainVC = navC.topViewController as! ViewController
        cell.tableNewGameNameLabel.text = mainVC.table.getTablesNameArray()[indexPath.row]
        if cell.tableNewGameNameLabel.text == mainVC.table.currentTableRealName {
            cell.backgroundColor = UIColor(red: 0x00/255, green: 0xC8/255, blue: 0xFF/255, alpha: 1.0)
        }
        else {
            cell.backgroundColor = UIColor(red: 0xA1/255, green: 0xDB/255, blue: 0x12/255, alpha: 1.0)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var alert = UIAlertController(title: "New game", message: "Are you sure to start new game?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: { action in
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TableCollectionViewCell
            let navC = self.presentingViewController as! UINavigationController
            let mainVC = navC.topViewController as! ViewController
            mainVC.newGame(cell.tableNewGameNameLabel.text!)
            self.returnToMainVC()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
