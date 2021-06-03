//
//  Common.swift
//  17SHAKE
//
//  Created by fz808 on 2021/6/2.
//

import UIKit

// 屏幕宽高
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

// key window
let KeyWindow = UIApplication.shared.keyWindow

// 判断机型是否为iPhone
let kIsIphone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

// 判断是否为iPhone X
let kIsIphoneX = Bool(kScreenWidth >= 375.0 && kScreenHeight >= 812.0 && kIsIphone)

// 状态栏高度
let kStatusBarHeight = CGFloat(kIsIphoneX ? 44 : 20)

// 导航高度
let kNavigationBarHeight = CGFloat(kIsIphoneX ? 88 : 64)

// tabbar高度
let kTabBarHeight = CGFloat(kIsIphoneX ? (49 + 34) : 49)


// 自定义颜色
func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

// 字号
//func customFont(fontSize: CGFloat) -> UIFont {
//    
//}
