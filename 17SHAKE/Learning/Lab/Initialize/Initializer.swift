//
//  Initializer.swift
//  17SHAKE
//
//  Created by fz on 2021/4/22.
//

import Foundation

/*
 * 初始化器的相互调用规则
 * 1、指定初始化器必须从它的直系父类调用指定初始化器
 * 2、便捷初始化器必须从相同的类里调用另一个初始化器
 * 3、便捷初始化器最终必须调用一个指定初始化器
 */
class ISize {
    var width : Int
    var height : Int
    
    //  自定义指定初始化器后，默认的执行初始化器就不存在了， self.init()此时不存在
     init(width:Int, height:Int) {
        
        self.width = width
        self.height = height
    }
    
    init(height:Int){
        self.width = 10
        self.height = height
    }
    
    // 1、便捷初始化器, 必须调用一个自身的指定初始化器（不能调用父类的指定初始化器）
    convenience init(width:Int){
        // 2、指定初始化器一定要放在前面
        self.init(width: width, height: 0) // 默认的指定初始化器
    }
}

class SSize : ISize {
    var name : String
    // 1、自定义指定初始化器后，父类的指定初始化器不会被继承
    // 2、指定初始化器调用初始化器的话，只能调用父类的初始化器，不能调用便捷初始化器
    init(width:Int, height:Int, name:String){
        //  在指定初始化器调用之前初始化特有的属性，
        self.name = name
        
        super.init(width: width, height: height)
    }
    
    convenience init(abc: Int){
        self.init(width:0, height:0, name:"")
    }
    
    deinit {
        
    }
    
//    required
}

let s = SSize(width: 10, height: 10, name: "size")

struct Rect {
    var width : Int
    var height : Int
}

let rect = Rect(width: 20, height: 20)


/*
 * 可选链 Optional Chaining
 */
