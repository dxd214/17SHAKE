//
//  Type.swift
//  17SHAKE
//
//  Created by fz808 on 2021/5/13.
//

import Foundation

func equals<T:Equatable>(_ firstEle:T, secondEle:T) -> Bool {
    return firstEle == secondEle
}

class CustomObj : Equatable {
    
    var name:String?
    
    init(name:String) {
        self.name = name
    }
    
    static func == (lhs: CustomObj, rhs: CustomObj) -> Bool {
        lhs.name == rhs.name
    }
    
}
