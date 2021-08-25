//
//  SHUser.swift
//  17SHAKE
//
//  Created by gyh on 2021/8/13.
//

import Foundation


@objc protocol UserProtocol {
    @objc optional func doSth()
}

extension UserProtocol {
    
}

// MARK: - 单例模式
// FIXME: - 单例模式
// TODO: - 单例模式
class SHUser : UserProtocol {
    // 单例
    static let sharedUser = SHUser()
    private init() { }
    
    func test(){
        let num = Int("123")
        print(num)
        
        类().招呼(名字: "Dog")
    }
}

class 类: NSObject {
    func 招呼(名字: String){
        print("Hello \(名字)")
    }
}
