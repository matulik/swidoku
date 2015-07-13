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
    
    init() {
        for c in 0..<10 {
            self.contentTable.append(Array(count: 9, repeatedValue: Int()))
        }
        for i in 0..<9 {
            for n in 0..<9 {
                self.contentTable[i][n] = 0
            }
        }
    }
    
    func getXYValue(x: Int, y: Int) -> Int {
        // Bad XY Value = -1
        if (x < 0 || x > 9 || y < 0 || y > 9) {
            return -1
        }
        else {
            return self.contentTable[2][3]
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
}