//
//  LProtocol.swift
//  17SHAKE
//
//  Created by Yehua Gao on 2020/4/6.
//  Copyright © 2020 com.berman.www. All rights reserved.
//

import Foundation

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}


protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}


struct Person: AnotherProtocol {
    
    static var someTypeProperty: Int {
        get {
            return 10
        }
        set {
//            _someTypeProperty = newValue
        }
    }
    
//    var someTypeProperty: Int
}

class A {
    
    func test(){
//        Notification.Name("")
    }
    
    deinit {
        
    }
}
