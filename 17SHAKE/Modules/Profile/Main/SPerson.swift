//
//  Person.swift
//  17SHAKE
//
//  Created by gyh on 2021/8/16.
//

import Foundation

class SPerson {
    let name: String
    lazy var printName: ()->() = {
        [weak self] in
        if let strongSelf = self {
            print("The name is \(strongSelf.name)")
        }
    }
    /*
     self -> 闭包 -> self 造成循环引用
     lazy var printName: ()->() = {
        print("The name is \(self.name)")
     }
     */
    
    init(personName: String) {
        name = personName
    }
    
    func loadBigData() {
//        DispatchQueue.global().async {
//            if let path = Bundle.main.path(forResource: "ARM", ofType: "pdf") {
//                for i in 1...100000 {
//                    autoreleasepool {
//                        let data = NSData(contentsOfFile: path)
//                        print("\(i)")
//                    }
//                }
//            }
//        }
    }
    
    deinit {
        print("Person deinit \(self.name)")
    }
}
