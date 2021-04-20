//
//  SH_HomeController.swift
//  17SHAKE
//
//  Created by gyh on 2019/12/10.
//  Copyright © 2019 com.berman.www. All rights reserved.
//

import UIKit
import OpenGLES
import Metal
import WebKit
import SnapKit
import Kingfisher
import Alamofire

class SH_HomeController: SH_BaseController {
    
    //    let waterfallListView = UICollectionView()
    let pageControl = UIPageControl()
    
    lazy var webView : WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    func setupView(){
//        let configuration = WKWebViewConfiguration()
//        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
//        self.view.addSubview(webView)
//
//        webView.snp.makeConstraints { (make) in
//            make.width.height.left.top.equalTo(self.view)
//        }
        
//        testNetwork()
        
        testClosureExpression()
        
        let textLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 60))
        textLabel.text = "123"
        textLabel.textColor = .cyan
        textLabel.font = .preferredFont(forTextStyle: .title1)
        self.view.addSubview(textLabel)
    }
    
    
    typealias Fn = (Int) -> Int
    
    func getFn() -> Fn {
        var num = 0
        func plus(_ i:Int) -> Int {
            num += i
            return num
        }
        return plus
    }
    
    func testClosureExpression() {
        
//        let fn = getFn()
//        print(fn(1))
//        print(fn(2))
//        print(fn(3))
//        print(fn(4))
        
        let fn1 = getFn()
        let fn2 = getFn()
        let fn3 = getFn()
        let fn4 = getFn()
        print(fn1(1))
        print(fn2(2))
        print(fn3(3))
        print(fn4(4))
        
//        let fn = {
//            (v1:Int, v2: Int) -> Int in
//            return v1 + v2
//        }
        
        
//        let fn = { $0 }
//        print(fn(10,11))
        
//        exec(v1: 18, v2: 19, fn: {$0 + $1})
        
//        print(exec1())
    }
    
//    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
//        print(fn(v1, v2))
//    }
    
    func exec1(v1:Int = 10, v2:Int = 29) -> Int{
       return v1 + v2
    }
    
//    let exec2 = { $0 + $1 }
    
    func testSth() {
        //        self.printPropertyList()
        
        //        print(TestNum.FIRST.rawValue)
        
        //        print(testFucntion(cal: 1, second: 2))
        
        //        let f: Double = 1.0
        
//        let p1 = Point()
//        print(p1.x)
//
//        print("point.x值为\(String(describing: p1.x))")
//        print("point.x",p1.x)
        
//        let ptr = malloc(16)
//        malloc_size(ptr)
        
        //        let e = TestNum.test2(false)
        //        switch e {
        //        case let .test1(v):
        //            print("test1",v)
        //        case let .test2(v):
        //            print("test2",v)
        //        default:
        //            print("-=-=-=-----")
        //        }
    }
    
    func testUIMenu() {
        navigationController?.isToolbarHidden = false
        
        if #available(iOS 14.0, *) {
            let addNewItem = UIBarButtonItem(systemItem: .add, primaryAction: nil, menu: createMenuIOS13())
            //            toolbarItems = [addNewItem]
            navigationItem.rightBarButtonItem = addNewItem
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// 测试图片缓存
    func testImageCache() {
//        let imgView = UIImageView()
//        imgView.kf.setImage(with: <#T##Resource?#>)
    }
    
    
    func testNetwork(){
        
        let urlStr = "http://www.baidu.com".urlEncode()
        
        AF.request(urlStr).responseString(completionHandler: { (response) in
            guard let res = response.value else {
                print("百度请求失败：",response.error?.localizedDescription as Any)
                return
            }
            
            print("当前线程:",Thread.current);
            
            print("百度请求返回：",res)
            let url = URL(string: urlStr)!
            let request = URLRequest(url: url)
            self.webView.load(request)
        })
        
        
       
        
        
    }
    
    
    
    func testFucntion(cal first:Int, second:Int) -> Int{
        first + second
    }
    
    @available(iOS 13.0, *)
    func createMenuIOS13() -> UIMenu {
        // 第一个菜单
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { _ in
            print("favorite")
        }
        // 第二个菜单
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
            print("share")
        }
        // 第三个菜单
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { _ in
            print("delete")
        }
        
        let menuActions = [favorite, share, delete]
        
        let addNewMenu = UIMenu(
            title: "",
            children: menuActions)
        
        return addNewMenu
    }
    
    
    // 打印属性列表
    func printPropertyList(){
        var count:UInt32 = 0
        
        let properties = class_copyPropertyList(UIPageControl.self, &count)
        //        print(properties!)
    }
    
    //    - (void)printPropertyList {
    //        unsigned int count;
    //
    //        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    //        for (unsigned int i = 0; i < count; i++) {
    //            const char *propertyName = property_getName(propertyList[i]);
    //            NSLog(@"propertyName(%d) : %@", i, [NSString stringWithUTF8String:propertyName]);
    //        }
    //
    //        free(propertyList);
    //    }
    
    //    func test(){
    //        let a = ["1","2","3"]
    //        a.forEach { print("输出\($0)")
    //        }
    //    }
    
    
}


//extension SH_HomeController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell = tableView .dequeueReusableCell(withIdentifier: SH_HomeController.cellIdentifier, for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"
//        return cell
//    }
//}
//
//extension SH_HomeController: UITableViewDelegate {
//
//}

/*
 var listView : UITableView? = nil
 static let cellIdentifier : String = "cellIdentifier"
 var testNum = 10
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 self.setupView()
 
 self.loadCategoryList()
 
 self.modifyTestNum(&testNum)
 }
 
 func modifyTestNum(_ num : inout Int){
 print("运算前\(num)")
 num += 5
 print("运算后\(num)")
 
 let isFlag = num is String
 print("\(isFlag)")
 }
 
 func loadCategoryList(){
 AF.request(API.home_category).responseJSON{ response in
 //            print(response.value!)
 guard let dict = response.value else { return }
 print(dict)
 
 }
 }
 
 func setupView(){
 self.navigationItem.title = sh_tab_home.localizedString
 self.listView = UITableView(frame: self.view.bounds, style: .plain)
 self.listView?.dataSource = self;
 self.listView?.delegate = self;
 self.listView?.register(UITableViewCell.self, forCellReuseIdentifier: SH_HomeController.cellIdentifier)
 self.view.addSubview(self.listView!)
 }
 */
