//
//  HViewModel.swift
//  17SHAKE
//
//  Created by gyh on 2021/7/7.
//

import UIKit
import RxSwift

class HViewModel {
    var herosObservable : Variable<[Hero]> = {
        var heros: [Hero] = [Hero]()
//        for 0...10 in [1,2,3,4,5,6,7,8,9,10,11] {
//            
//        }
        return Variable(heros)
    }()
}
