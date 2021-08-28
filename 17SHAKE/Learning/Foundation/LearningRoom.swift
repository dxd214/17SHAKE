//
//  StringRoom.swift
//  17SHAKE
//
//  Created by gyh on 2021/8/19.
//

import Foundation
import Darwin

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
 @escaping 逃逸闭包，一个接受闭包作为参数的函数，该闭包可能在函数返回后才被调用
 @autoclosure 做的事情就是把一句表达式自动地封装成一个闭包 (closure)
 */
class ClosureRoom {
    func test() {
        getData { (data) in
            print("逃逸闭包结果返回-\(data)")
        }
        
        doWork {
            print("非逃逸闭包")
        }
        
        logIfTrue(2 > 1)
    }
    
    func logIfTrue(_ predicate:@autoclosure () -> Bool) {
        if predicate() {
            print("TRUE")
        }
    }
    
    func getData(closure:@escaping (Any) -> Void){
        print("----1")
        
        /*
         DispatchQueue.main.async
         
         DispatchQueue.global().async
         
         */
        
        DispatchQueue.global().async {
            print("----2")
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                closure("abc")
//            }
            print("----3")
        }
    }
    
    func doWork(closure:()->()){
        closure()
    }
}

class EnumerateRoom {
    func test() {
        let arr = [1,2,3,4,5]
        for (i, o) in arr.enumerated(){
            print("i:\(i),o:\(o)")
        }
        
        let nsarr: NSArray = [1,2,3,4,5]
        nsarr.enumerateObjects({(num,index,stop) -> Void in
            print("index:\(index),num:\(num)")
            if index == 2 {
                stop.pointee = true
            }
        })
        
        let int:Int = 10
        let intNum: NSNumber = int as NSNumber
        
        let float:Float = 10.0
        let floatNum: NSNumber = float as NSNumber
        
        print(String(validatingUTF8: intNum.objCType))
        
        
    }
}

class EncodeRoom {
    
    /*
     可以使用@_silgen_name将printC函数直接映射为 Swift 函数swift_print，这样就不需要在桥接文件中导入 C 语言头文件，甚至可以直接删掉 C 语言头文件
     */
//    @_silgen_name("testCMethod") func c_test(a:Int32) -> Int32
    
    // 隐藏符号@asmname，在swift 2.0之前
//    @asmname("test") func c_test(a:Int32) -> Int32
    
    func test() {
//        @encode(Int32)
//        print(c_test(a: 1))
//        print(testCMethod(1))
    }
}


/*
 ?? 操作符 可以判断输入并在当左侧的值是非 nil 的 Optional 值时返回其 value，当左侧是 nil 时返回右侧的值
 */
class InitialRoom {
    func test() {
        let url: URL? = URL(string: "http://swifter. tips")
        print(url)
        
        let isEmpty = url ?? nil
        
        // 反射机制
        let s = Mirror(reflecting: ["1","2","3","4"])
        
//        print("---\(s.displayStyle)")
        for child in s.children {
//            print(child)
            dump(child)
        }
        
        var dict = [String: AnyObject]()
        dict["a"] = "123" as NSString
        print(dict)
        
        
        let nameList = ["王小二","张三","李四","王二小"]
        nameList.forEach { (ele) in
            switch ele {
            case let x where x.hasPrefix("王"):
                print(x)
                
            default:
                print(ele)
            }
        }
    }
    
    
    /*
     补充：
     AnyObject: 代表任何class类型的对象实例。
     Any: 可以代表任何类型，甚至包括方法(func)类型。
     AnyClass: 使用不多，更多体现在系统内的使用。
     */
}


class TEST{
    var num1 = 10
    
    func testT() {
        Car.num2 = 11
        
        
        try? testError()
        
        /*
         *  3、try？ try!
         * 使用try？ try!调用可能会抛出error的函数，这样就不用处理error
         */

        print(try? divide(2, num2: 0))
        
        fun1()
    }

    class Car {
        //  num2是全局变量，默认lazy修饰，与num1区别在于访问权限
        public static var num2 = 0
    }
    
    /*
     *  1、自定义异常
     */
    enum TestError : Error {
        case IllegalArguments(String)
        case OutOfBounds(Int,Int)
    }

    @discardableResult func divide(_ num1: Int, num2: Int) throws -> Int {
        if (num2 == 0){
            throw TestError.IllegalArguments("0不能作为除数")
        }
        return num1/num2
    }

    /*
     *  2、捕捉异常
     */
    func testError() throws{
        do {
            let res = try divide(10, num2: 0)
            Swift.print(res)
        } catch let TestError.IllegalArguments(msg) {
            Swift.print(msg)
        }
        
        Swift.print("======")
    }

    /*
     *  4、rethrows
     *  rethrows表明：函数本身不会抛出错误，但调用闭包参数抛出错误，那么它会将错误向上抛
     */
    func exec(_ fn:(Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
        print(try fn(num1, num2))
    }

    //try exec(divide, 20, 0)


    /*
     *  5、defer
        defer语句：用来定义任何方式（抛错误，return等）离开代码块前必须要执行的代码
        defer语句将延迟至当前作用域结束之前执行
        defer语句的执行顺序与定义顺序相反
     */

    func fun1() {
        defer {
            print("---1---")
        }
        
        defer {
            print("---2---")
        }
    }
}

/*
 Swift 的 protocol 是可以被除了 class 以外的其他类型遵守的，而对于像 struct 或是 enum 这样的类型，本身就不通过引用计数来管理内存，所以也不可能用 weak 这样的 ARC 的概念来进行修饰。

 想要在 Swift 中使用 weak delegate，我们就需要将 protocol 限制在 class 内。一种做法是将 protocol 声明为 Objective-C 的，这可以通过在 protocol 前面加上 @objc 关键字来达到，Objective-C 的 protocol 都只有类能实现，因此使用 weak 来修饰就合理了
 
 class显示声明ClassDelegate这个protocol只能由class来实现
 */
protocol ClassDelegate:class {
    func method()
}

class MyClass {
    weak var delegate: ClassDelegate?
}

class DelegateRoom: ClassDelegate {
    var instance: MyClass!
    
    func test() {
        instance = MyClass()
        instance.delegate = self
    }
    
    func method() {
        
        /*
         1..<10    1,2...9
         1...10    1,2...9,10
         */
        for index in 1...10 {
            let num = random(in: Range<Int>(1...6))
//                arc4random() % 10
            print("序号：\(index)，随机数：\(num)")
        }
        
        let range1 = 1.0...5.0
        print(range1.contains(3.8338))
//        for ele in range1 {
//            print(ele)
//        }
        
        var contents = [Int]()
        contents.append(Int("123") ?? 0)
        
    }
    
    func random(in range:Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return Int(arc4random_uniform(count)) + range.startIndex
    }
    
    
}

/*
 线程安全
 */
class LockRoom {
    func testMethod(anObj: AnyObject) {
        objc_sync_enter(anObj)
        
        objc_sync_exit(anObj)
    }
    
    func synchronized(_ lock: AnyObject, closure: ()->()){
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}

/*
 associatedtype
 typealias
 */
protocol Animal {
    associatedtype F
    func eat(_ food:F)
}

protocol Food {
    
}

struct Meat: Food{
    
}

struct Grass: Food {
    
}

struct Tiger: Animal {
    typealias F = Meat
    func eat(_ food: F) {
        
    }
}

struct Sheep: Animal {
    typealias F = Grass
    func eat(_ food: F) {
        
    }
}

class AssociatedTypeRoom {
    func isDangerous<T:Animal>(animal:T) -> Bool {
        return animal is Tiger
    }
    
    func test() {
        print(isDangerous(animal: Tiger()))
        print(isDangerous(animal: Sheep()))
    }
}

/*
 可变参数
 */
class MutableArgumentClass{
    func sum(input: Int...) -> Int {
        return input.reduce(0,+)
    }
}
