//
//  Direction.swift
//  17SHAKE
//
//  Created by Yehua Gao on 2020/3/11.
//  Copyright © 2020 com.berman.www. All rights reserved.
//

import Foundation

enum Direction: CaseIterable {
    case east, south, west, north
}

let sh_tab_home = "sh_tab_home"
let sh_tab_discover = "sh_tab_discover"
let sh_tab_comment = "sh_tab_comment"
let sh_tab_profile = "sh_tab_profile"


enum TestNum {
    case FIRST
    case SECOND
    case THIRD
    case test1(Int)
    case test2(Bool)
}


struct Point {
    var x: Int?
    var y: Int?
    
//    init() {
//
//    }
    
//    自定义初始化器后，初始化方法就只能按照初始化器格式来
//    init(x:Int?, y:Int?) {
//        self.x = x
//        self.y = y
//    }
}
