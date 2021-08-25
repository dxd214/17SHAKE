//
//  LabModel.swift
//  SShakeLab
//
//  Created by fz on 2021/4/13.
//

import UIKit
/*
 
 @objc的使用场景
 1、protocol如果是optional(非必须实现)的，必须加上@objc，在protocol前也需要加上@objc
 2、利用#selector调用的方法,被调用的方法须加上@objc
 3、kvc其实也是利用了oc的运行时特性，所以使用kvc也需要在属性前加上@objc
 4、NSPredicate是利用对象属性的key进行筛选的属性，要加上@objc，实际上NSPredicate也是利用了对象的oc对象的kvc特性
 5、oc与swift混合开发，swift方法/属性/枚举需要被oc调用的，属性/方法/枚举前需要加上@objc
 
 @objc 与 @objcMembers的区别
 在Swift中，继承自NSObject的类如果有比较多的属性或方法都需要加上@objc的话，会多比较多的代码。那么可以利用@objcMembers减少代码。被@objcMembers修饰的类，会默认为类、子类、类扩展和子类扩展的所有属性和方法都加上@objc。当然如果想让某一个扩展关闭@objc，则可以用@nonobjc进行修饰
 
 */

@objc enum Sex:Int {
    case male
    case female
}

enum ESize {
    case large
    case medium
    case small
}


// 5、oc与swift混合开发
class People: NSObject {
    @objc var name = ""
    
    @objc func playGame() {
        print("玩游戏")
    }
}

// 1、protocol
@objc protocol LabProtocol {
    @objc optional func labReadyToView()
}


class LabModel: NSObject, NSCoding {
    
    // 3、使用kvc（dynamic可以取消）
    @objc var name = ""
    @objc var age = 0
    
    override init() {
        print(Sex.male.rawValue)
    }
    
    override var description: String{
        get {
            return "实例信息---name:\(self.name), age:\(self.age)"
        }
    }
    
    deinit {
        print("\(self.name)---LabModel被释放---")
    }
    
    required init?(coder: NSCoder) {
        super.init()
        
        var count: UInt32 = 0
        guard let ivars = class_copyIvarList(self.classForCoder, &count) else {
            return
        }
        
        for i in 0...count-1 {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            let key = String.init(utf8String: name!)!
            if let value = coder.decodeObject(forKey: key){
//                kvc赋值
                self.setValue(value, forKey: key)
            }
        }
        free(ivars)
    }
    
    
    func encode(with coder: NSCoder) {
        var count: UInt32 = 0
        guard let ivars = class_copyIvarList(self.classForCoder, &count) else {
            return
        }
        
        for i in 0...count-1 {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            let key = String.init(utf8String: name!)!
            
//            使用kvc取值
            if let value = self.value(forKey: key){
                coder.encode(value, forKey: key)
            }
        }
        free(ivars)
    }
}


class LabView:UIView {
    
    var btn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btn = UIButton(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        btn?.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
    }
    
// 2、利用#selector调用的方法
    @objc func clickBtn(_ sender:UIButton) {
        print("--- click btn ---")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




@objcMembers
class Model: NSObject {
    var name = ""
    var address = ""
}

@nonobjc
extension Model {
    func defaultName(){
        self.name = "Jack"
    }
}
