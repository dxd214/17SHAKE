//
//  QCodeController.swift
//  17SHAKE
//
//  Created by gyh on 2021/7/7.
//

import UIKit

class QCodeController: SH_BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testCollection()
    }
    
    // MARK: ------ 集合 ------
    func testCollection(){
        var collectionA = [1,2,3,4,5]
        let collectionB = [6,7,8,9,10]
        let collectionC = collectionA + collectionB
        collectionA += collectionB
        print(collectionA)
        print(collectionC)
    }
    
//    func loadSignature() async throws -> String {
//        fatalError("暂未实现")
//    }
}
