//
//  SH_AboutController.swift
//  17SHAKE
//
//  Created by gyh on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa

class SH_AboutController: SH_BaseController {

    let btn = UIButton()
    
    let textfiled = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testCombine()
    }
    
    func testCombine(){
        
        btn.setTitle("按钮", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(30)
        }
        btn.rx.tap.subscribe { (event) in
            print("-=-=-=-=-=-=-\(event)")
        }

//        AsyncSubject
//        Observable
//        amb
        
        
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
        }
        
        textfiled.rx.text.bind(to:label.rx.text)
        
        btn.rx
    }
    
}
