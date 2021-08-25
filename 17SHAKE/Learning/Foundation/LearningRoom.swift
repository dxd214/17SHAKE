//
//  StringRoom.swift
//  17SHAKE
//
//  Created by gyh on 2021/8/19.
//

import Foundation

class StringRoom {
    func test() {
        let s: String = "123456"
        s.contains("a")
        
        guard let range = s.range(of: "12") else { return }
        s.replacingCharacters(in: range, with: "123")
         
    }
    
    deinit {
        print("StringRoom ~~~ deinit")
    }
   
}

// 内存管理
class UnSafePointerRoom {
    func test() {
//        let arr = NSArray(object: "Hello")
        // 强制转换
//        let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: String.self)
//        print(str)
        
        var a: CInt = 123
        method(&a)
        
        // UnsafeMutablePointer不会自动进行内存管理
        var pointer: UnsafeMutablePointer<StringRoom>!
        pointer = UnsafeMutablePointer<StringRoom>.allocate(capacity: 1)
        pointer.initialize(to: StringRoom())
        
        pointer.deinitialize(count: 1)
        pointer.deallocate()
        pointer = nil
        
        /*
         在手动处理这类指针的内存管理时，我们需要遵循的一个基本原则就是谁创建谁释放。deallocate 与 deinitialize 应该要和 allocate 与 initialize 成对出现，如果不是你创建的指针，那么一般来说你就不需要去释放它。
         
         */
//        print(pointer.pointee)
        
        
//        let callback: @convention()
    }
    deinit {
        print("deinit~~~UnSafePointerRoom")
    }
    
    /*
     UnsafeMutablePointer 对应C语言中的 Type *
     */
    func method1(_ num:UnsafeMutablePointer<CInt>){
        print(num.pointee)
    }
    
    /*
     UnsafePointer 对应C语言中的 const Type *
     
     当前方法C版本为:
     void method(const int *num){
        printf("%d",*num);
     }
     */
    func method(_ num:UnsafePointer<CInt>){
        print(num.pointee)
    }
}


// GCD
class GCDRoom:NSObject {
    var room: KVORoom! = KVORoom()
    var context: UnsafeRawBufferPointer?
    var observation: NSKeyValueObservation?
    
    func test(){
        DispatchQueue.global().async {
            print("子线程～～～")
            DispatchQueue.main.async {
                print("主线程～～～")
            }
        }
        
        let date = NSDate()
        let cls: AnyClass = object_getClass(date)!
        print(cls)
        
        let s1 = StructRoom()
        let s2 = GCDRoom()
        
        /*
         对于一个不确定的类型，我们现在可以使用 is 来进行判断。is 在功能上相当于原来的 isKindOfClass，可以检查一个对象是否属于某类型或其子类型。is 和原来的区别主要在于亮点，首先它不仅可以用于 class 类型上，也可以对 Swift 的其他像是 struct 或 enum 类型进行判断。
         */
        let res = s1 is GCDRoom
        print(res)
        
        
        // KVC 方式1:addObserver
//        room.addObserver(self, forKeyPath: "name", options:.new, context: nil)
        
        /*
         KVC 方式2:observe
         when the returned NSKeyValueObservation is deinited or invalidated, it will stop observing
         即需要定义一个属性observation持有
         */
        
        // KVC 方式3:重载添加观察
        observation = room.observe(\.name, options:.new) { (_, change) in
            print("---")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.room.name = "123"
            self.room.default = "default"
            print(self.room.default)
            
            self.room.test()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change)
    }
    
    deinit {
//        self.room.removeObserver(self, forKeyPath: "name")
    }
}

struct StructRoom {
    var name: String?
    var address: String?
}

precedencegroup MyPrecedence {
    lowerThan:AdditionPrecedence
}

infix operator >>> : AdditionPrecedence

func >>> <A, B, C>(_ f1:@escaping (A) -> B, _ f2:@escaping (B) -> C) -> (A) -> C {
    {f2(f1($0))}
}

func add(_ v: Int) -> (Int) -> Int {
    return { v1 in
        v1 + v
    }
}

func sub1(_ v: Int) -> (Int) -> Int { { $0 - v } }
func multiple(_ v: Int) -> (Int) -> Int { { $0 * v } }
func devide(_ v: Int) -> (Int) -> Int { { $0 / v } }
func mod(_ v: Int) -> (Int) -> Int { { $0 % v } }

class KVORoom: NSObject {
    /*
     KVC涉及的属性需要用@objc dynamic修饰
     */
    @objc dynamic var name: String?
    var `default`:String?
    
    func test() {
        
        let fn = addCur(a: 10)
        do {
            print(fn(20))
            
            print(addCur(a: 10)(20))
            
            let fn = add(3) >>> multiple(5) >>> sub1(1) >>> mod(10)
            print(fn(1))
        }
        
        
    }
    
    func sub(){
        
    }
    
    func addCur(a: Int) -> (Int) -> Int{
        return  {
            $0 + a
        }
    }
}

/*
 函数式编程
 柯里化
 */



/*
 @escaping 逃逸闭包，一个接受闭包作为参数的函数，该闭包可能在函数返回后才被调用，
 */
class ClosureRoom {
    func test() {
        getData { (data) in
            print("闭包结果返回-\(data)")
        }
    }
    
    func getData(closure:@escaping (Any) -> Void){
        print("----1")
        DispatchQueue.global().async {
            print("----2")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                closure("abc")
            }
            print("----3")
        }
    }
}
