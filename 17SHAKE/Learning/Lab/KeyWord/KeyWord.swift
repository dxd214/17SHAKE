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


// 访问级别
// private  当前类中可以访问
// fileprivate (当前文件内都可以访问)
// internal (默认类或者成员变量、方法的访问级别)
// public
// open

class PP {
    
    fileprivate let name : String = ""
    
    internal func run() {
        
    }
}

class p1 : PP {
    override func run() {
        let pp1 = PP()
        print(pp1.name)
    }
}
