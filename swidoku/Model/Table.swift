//
//  Table.swift
//  swidoku
//
//  Created by CS_praktykant on 13/07/15.
//  Copyright (c) 2015 mt. All rights reserved.
//

import Foundation

class Table {
    var contentTable = Array<Array<Int>>()
    var currentTableName : String = ""
    
    init() {
        for c in 0..<9 {
            self.contentTable.append(Array(count: 9, repeatedValue: Int()))
        }
        for x in 0..<9 {
            for y in 0..<9 {
                self.contentTable[x][y] = 0
            }
        }
        println(self.getTablesNameArray())
    }
    
    func setArray(x : Array<Array<Int>>) {
        for i in 0..<9 {
            for n in 0..<9 {
                self.contentTable[i][n] = x[i][n]
            }
        }
    }
    
    func getArray() -> Array<Array<Int>> {
        return self.contentTable
    }
    
    func getXYValue(x: Int, y: Int) -> Int {
        // Bad XY Value = -1
        if (x < 0 || x > 9 || y < 0 || y > 9) {
            return -1
        }
        else {
            return self.contentTable[x][y]
        }
    }
    
    func setXYValue(x: Int, y: Int, v:Int) -> Int {
        // Bad XY Value = -1
        if (x < 0 || x > 9 || y < 0 || y > 9) {
            return -1
        }
        // Bad Value = -2
        else if (v < 0 || v > 9) {
            return -2
        }
        // OK = 0
        else {
            self.contentTable[x][y] = v
            return 0
        }
    }
    
    // @S - square (0,1,2,10,11,12,20,21,22)
    func checkSquare(tag: Int) -> Bool {
        let x : Int = (tag/10)*3
        let y : Int = (tag - (tag/10)*10)*3

        var checkArray = [Int](count: 9, repeatedValue: 0)
        
        for n in x..<x+3 {
            for m in y..<y+3 {
                if (self.getXYValue(n, y: m) != 0) {
                    checkArray[self.getXYValue(n, y: m)-1]++
                }
            }
        }
        //println("checkSquare: \(checkArray)")
        for i in 0..<9 {
            if checkArray[i] != 1 {
                return false
            }
        }
        return true
    }
    
    // @pos - x/y first position, @p - Horizontal(True), Vertical(False)
    func checkLine(pos: Int, h: Bool) -> Bool {
        var checkArray = [Int](count: 9, repeatedValue: 0)
        for i in 0..<9 {
            if (h == true) {
                if(self.getXYValue(pos, y: i) != 0) {
                    checkArray[self.getXYValue(pos, y: i)-1]++
                }
            }
            else {
                if(self.getXYValue(i, y: pos) != 0) {
                    checkArray[self.getXYValue(i, y: pos)-1]++
                }
            }
        }
        //println("checkLine: \(checkArray)")
        for i in 0..<9 {
            if checkArray[i] != 1 {
                return false
            }
        }
        return true
    }
    
    func checkTable() -> Bool {
        // Squares checking
        if !(self.checkSquare(0) && self.checkSquare(1) && self.checkSquare(2) && self.checkSquare(10) && self.checkSquare(11) && self.checkSquare(12) && self.checkSquare(20) && self.checkSquare(21) && self.checkSquare(22)) {
            return false
        }
        
        for i in 0..<9 {
            // Horizontal checking
            if (self.checkLine(i, h: true) == false ){
                return false
            }
            
            // Vertical checking
            if (self.checkLine(i, h: false) == false) {
                return false
            }
        }
        return true
    }
    
    // To read JSON table file and set into self table. Remember to keep "sudokuTable" key in json file
    // TODO method to check if JSON is right
    func readJSONTableFromFile(name : String) -> Bool {
        let path = NSBundle.mainBundle().pathForResource("Tables/"+name, ofType: "json")
        if let data = NSData(contentsOfFile: path!, options: NSDataReadingOptions.allZeros, error: nil) {
            let json = JSON(data : data)
            for x in 0..<9 {
                for y in 0..<9 {
                    self.setXYValue(x, y: y, v: json["sudokuTable"][x][y].int!)
                }
            }
            return true
        }
     return false
    }
    
    // To save table into JSON file - to continue last game
    func saveCurrentTable() {
        // Keep last table name
        let text : String = self.currentTableName
        let path = (NSBundle.mainBundle().resourcePath!)+"/Tables/last.name"
        println(path)
        text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
        // Save to string
        let path_table = (NSBundle.mainBundle().resourcePath!)+"/Tables/last.table"
        println(path_table)
        var temp : String = ""
        for x in 0..<9 {
            for y in 0..<9 {
                temp = temp + String(format: "%d", self.getXYValue(x, y: y))
            }
        }
        temp.writeToFile(path_table, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
        

    }
    
    // Return count of sudoku tables 
    func getTablesCount() -> Int {
        var count = 0
        let path = (NSBundle.mainBundle().resourcePath!)+"/Tables"
        let filemgr = NSFileManager.defaultManager()
        let filelist = filemgr.contentsOfDirectoryAtPath(path, error: nil)
        for filename in filelist! {
            let temp = filename as! String
            let range = Range(start: advance(temp.endIndex, -5), end: temp.endIndex)
            let json : String = temp.substringWithRange(range)
            if (json == ".JSON" || json == ".json") {
                count++
            }
        }
        return count
    }
    
    func getTablesNameArray() -> Array<String> {
        var array : Array<String> = Array<String>()
        var count = 0
        let path = (NSBundle.mainBundle().resourcePath!)+"/Tables"
        let filemgr = NSFileManager.defaultManager()
        let filelist = filemgr.contentsOfDirectoryAtPath(path, error: nil)
        for filename in filelist! {
            let temp = filename as! String
            var range = Range(start: advance(temp.endIndex, -5), end: temp.endIndex)
            let json : String = temp.substringWithRange(range)
            if(json == ".JSON" || json == ".json") {
                range = Range(start: temp.startIndex, end: advance(temp.endIndex, -5))
                array.append(temp.substringWithRange(range))
            }
        }
        return array
    }
}










