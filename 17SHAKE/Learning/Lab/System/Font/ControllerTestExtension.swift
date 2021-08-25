//
//  FontUtil.swift
//  SShakeLab
//
//  Created by fz on 2021/4/19.
//

import UIKit

extension UIViewController {
    /*
     * 打印支持的字体
     * 系统默认：FontFamilyCount:82, fontCount:276
     *
     */
    func printFontFamily() {
        var fontCount = 0
        var fontFamilyCount = 0
        for fontFamilyName in UIFont.familyNames {
            fontFamilyCount += 1
            print("------Family name:" + fontFamilyName)
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
                fontCount += 1
                print(fontName)
            }
        }
        
        print("FontFamilyCount:\(fontFamilyCount)"+", fontCount:\(fontCount)")
    }
    
    /*
     * 数组
     */
    func testArray() {
        let squared:[Int] = [1,3,4,5,6,8,9]
        for x in squared {
            print("x:",x)
        }
        
        for x in squared.dropFirst(0) {
            print("x:",x)
        }
    }
    
    /*
     * map/flatMap
     */
    func testMap(){
        // map
        let numbers = [1,2,3,4,5]
        let result = numbers.map({ "NO.\($0)" })
        numbers.forEach { ele in
            print("遍历元素：",ele)
        }
        print(result)
        
        // flatMap
        let numbersCompound = [[1,2,3],[4,5,6]]
        let result1 = numbersCompound.flatMap({$0.map({ $0 + 1 })})
        print(result1)
        
        // filter
        let arr = [10, 8, 11, 22, 31, 9, 4]
        let filteredArr = arr.filter({$0 >= 10})
        print(filteredArr)
        
        // allSatisfy: 判断所有元素是否都满足条件
        let satisfyArr = arr.allSatisfy({$0 >= 0})
        print(satisfyArr)
        
        // map和filter方法都是通过一个已存在的数组，生成一个新的、经过修改的数组。然而有时候我们需要把所有元素的值合并成一个新的值
        let sum: [Int] = [11, 22, 33, 44]
        // reduce 函数第一个参数是返回值的初始化值 result是中间结果 num是遍历集合每次传进来的值
        let initialValue = 110 // 初始化值（可以看作total的初始值）
        let total = sum.reduce(initialValue) { (result, num) -> Int in
            return result - num
        }
        print(total)
        
        
    }
}
