//
//  CustomModel.swift
//  SShakeLab
//
//  Created by fz on 2021/4/19.
//

import Foundation

struct CPoint {
    var x = 0
    var y = 0
    lazy var z = 0
}

/*
 *
 * 属性观察器
 * willSet 会传递新值，默认为newValue
 * didSet 会传递旧值，默认为oldValue
 * 在初始化器中设置属性值不会触发willSet和didSet
 *
 */
struct CCircle {
    var radius: Double {
        willSet(newRad){
            print("willset",newRad)
        }
        didSet{
            print("didset", oldValue, radius)
        }
    }
    
    var area: Double {
        set{
            
        }
        
        get{
            10.0
        }
    }
}

class CustomModel: CusProtocol {
    var cusText: String = ""
    
    func modify() {
        cusText = "asdasds"
    }
    
    func test() {
        var p = CPoint()
        
        /*
        let p = CPoint()
        print(p.z)
         当结构体包含一个延迟存储属性时，只有var才能访问延迟存储属性
         因为延迟属性初始化时需要改变结构体的内存
         */
        print(p.z)
    }
}


extension ViewController {
    
    func testC() {
        
        var a = [1,2,3]
        let b = [7,8,9]
        a.append(4)
        a.append(contentsOf: b)
        
    }
}


protocol CusProtocol {
    var cusText: String {
        get
    }
    
    func modify()
}
