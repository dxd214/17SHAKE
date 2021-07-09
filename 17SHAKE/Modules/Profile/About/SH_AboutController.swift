//
//  SH_AboutController.swift
//  17SHAKE
//
//  Created by gyh on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa
import Combine

class SH_AboutController: SH_BaseController {

    let btn = UIButton()
    
    let textfiled = UITextField()
    
    var titleStr: String?
    
    fileprivate lazy var disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testUIControlEvent()
//
//        testObservable()
        
//        testObservable1()
        
//        testSubjects()
        
        testCombine()
        
        let s = "ABC".lowercased()
        
        let addTwo = addTo(2)(6)
//        let result = addTwo(6)
        print(addTwo)
        
        let res = add(addNum: 6, adder: 2)
        print(res)
    }
    
    func add(addNum addNum: Int, adder: Int) -> Int {
        return addNum + adder
    }
    
    func addTo(_ adder: Int) -> (Int) -> Int {
        return {
            num in
            print("--\(num)--")
            return num + adder
        }
    }
    
    func testCombine(){
        print("*****startWith*****")
        /*
         startWith
         在开始从可观察源发出元素之前，发出指定的元素序列
         */
        Observable.of("1","2","3")
            .startWith("A")
            .startWith("abc")
            .subscribe { (str:String) in
                print("str:\(str)")
            } onDisposed: {
                print("---onDisposed---")
            }.disposed(by: disposableBag)

    }
    
    func testSubjects(){
        
        /*
         PublishSubject 订阅者只能接收订阅之后发出的事件
         */
        let publishSub = PublishSubject<String>()
        
        publishSub.onNext("publish-subject")
        
        publishSub.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
        
        
        publishSub.onCompleted()
    }
    
    func testObservable1() {
        print("------------never------------")
        let neverO = Observable<String>.never()
        neverO.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
        
        print("------------empty------------")
        let emptyO = Observable<String>.empty()
        emptyO.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
        
        print("------------just------------")
        let justO = Observable<String>.just("123")
        justO.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
        
        print("------------of------------")
        let ofO = Observable<String>.of("1","2","3")
        ofO.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
        
        print("------------from------------")
        let fromO = Observable<String>.from(["a","b","c"])
        fromO.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
        
        print("------------myJust------------")
        let myJustO = myJustObserver(element: "abs")
        myJustO.subscribe { (event:Event<String>) in
            print(event)
        }.disposed(by: disposableBag)
    }
    
    func testObservable() {
        //  可观察对象，用来发射数据，next事件表示发射新的数据
        let numbers : Observable<Int> = Observable.create { (observer) -> Disposable in
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onNext(6)
            observer.onNext(7)
            observer.onNext(8)
            observer.onNext(9)
            
            let err = SHError.normalError(msg: "测试异常")
//            err.localizedDescription
//            observer.onError(err)
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        // 监听
        numbers.subscribe { ( num: Int) in
            print("监听---\(num)")
        } onCompleted: {
            print("结束-----")
        }
        
        Observable.of(2,30,44,5,60,1).filter { ( num: Int) -> Bool in
            num > 30
        }.subscribe { ( res: Int) in
            print(res)
        }
        
        let arr = [10, 8, 30, 22, 80, 56]
        let ob = Observable.from(arr).filter { $0 > 10 }.subscribe { ( ele: Int) in
            print("ele:\(ele)")
        }
        defer {
            print("~~defer1~~")
        }
        defer {
            print("~~defer2~~")
        }
    }
    
    func testUIControlEvent(){
        
        let arr = [1,2,3,4,5]
        let arr2 = arr.filter({ $0 >= 2 }).map({ $0 * 2 })
        print("arr2:\(arr2)")
        
        btn.setTitle("按钮", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(30)
        }
        let btnOb = btn.rx.tap.share(replay: 1)
        btnOb.subscribe { (event) in
            print("=========")
        }
        btnOb.subscribe { (event) in
            print("-=-=-=-=-")
//            let anotherUserId = "234318151"
//            let currentUserId = "1977684473"
//            let teacherUserId = "122415430"
//            
//            let userId = currentUserId
//            
//            let normalURL = URL(string: "kingsuntbxpep://params?UserID=\(userId)&CatagoryID=0&SetHomeworkID=01c31535-37fd-407d-b0fa-7d1a2c52f65c&Type=0&JumpType=1&State=0")
//            let practiceURL = URL(string: "kingsuntbxpep://params?UserID=\(userId)&CatagoryID=51&SetHomeworkID=f8f7d934-6061-4ca5-951b-59d17abdf360&SetHomeworkItemID=28a7e0eb-5a9e-46ba-a4e6-127dfddc09b5&Type=0&JumpType=1&State=0")
//            let url = normalURL
//            
//            if UIApplication.shared.canOpenURL(url!) {
//                UIApplication.shared.openURL(url!)
//            }
        }
        
        let label = UILabel()
        self.view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(btn.snp_bottomMargin).offset(10)
            make.width.height.centerX.equalTo(btn)
        }
        
        textfiled.placeholder = "输入文本"
        textfiled.borderStyle = .bezel
        self.view.addSubview(textfiled)
        
        textfiled.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp_bottomMargin).offset(10)
            make.width.height.centerX.equalTo(btn)
        }
        
        textfiled.rx.text.subscribe { ( str: String?) in
            print("输入文本：\(str ?? "")")
            self.titleStr = str
            
        }
        
        textfiled.rx.text.bind(to:label.rx.text)
//        textfiled.rx.text.bind(to: btn.rx.title(for: .normal))
        
        textfiled.rx.controlEvent(.editingDidEndOnExit).subscribe { [weak self] (_) in
            print("退出编辑")
            self?.textfiled.resignFirstResponder()
        }
    }
    
}


extension SH_AboutController {
    fileprivate func createObserver() -> Observable<Any> {
        return Observable.create { ( observer: AnyObserver<Any>) -> Disposable in
            observer.onNext("-=-=-=-=-=-=-=")
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    fileprivate func myJustObserver(element: String) -> Observable<String> {
        
        /*
         Observable 让别人订阅事件
         Observer   发出事件
         */
        return Observable.create { ( observer: AnyObserver<String>) -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
