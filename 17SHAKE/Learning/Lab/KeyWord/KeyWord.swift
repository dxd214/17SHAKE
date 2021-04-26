//
//  KeyWord.swift
//  17SHAKE
//
//  Created by fz on 2021/4/22.
//

import Foundation

class PK : P {
    
    override var x : Int  {
        get {
            return 10
        }
        set {
            y = newValue
        }
    }
    
    @discardableResult func testReturnValue() -> Int {
        return 10
    }
    
    override func test() {
        super.test()
        print("pk-=-=-=-=-")
    }
}

class P {
    var x = 0, y = 0
    
    subscript(v1:Int, v2:Int) -> Int {
        return v1 + v2
    }
    
    
    subscript(index index:Int) -> Int {
        set {
            if (index == 0) {
                x = newValue
            }else if index == 1 {
                y = newValue
            }
        }
        get {
            if (index == 0) {
                return x
            }else if index == 1 {
                return y
            }
            return 0
        }
    }
    
    func test(){
        print("-=-=-=-")
    }
}
