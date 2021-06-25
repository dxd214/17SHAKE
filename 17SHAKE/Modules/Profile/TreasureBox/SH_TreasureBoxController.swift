//
//  SH_TreasureBoxController.swift
//  17SHAKE
//
//  Created by gyh on 2021/6/10.
//

import UIKit
import RxCocoa

class SH_TreasureBoxController: SH_BaseController {

    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "百宝箱"
        
        self.setupView()
    }
    
    func setupView() {
        
        let firstStackView = UIStackView()
        firstStackView.alignment = .fill
        firstStackView.axis = .horizontal
        firstStackView.distribution = .fillEqually
        
        self.view.addSubview(firstStackView)
        
        let netTestBtn = createBtn("网速检测")
        netTestBtn.rx.tap.subscribe { (onNext) in
            print("--网速检测--")
        }
        
        netTestBtn.rx.controlEvent(.touchUpOutside)
         

        firstStackView.addArrangedSubview(netTestBtn)
        
        let lightBtn = createBtn("闪光灯")
        lightBtn.addTarget(self, action: #selector(toLight), for: .touchUpInside)
        firstStackView.addArrangedSubview(lightBtn)
        
        let scanner = createBtn("二维码识别")
        firstStackView.addArrangedSubview(scanner)
        
        firstStackView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view)
            maker.height.equalTo(kScreenWidth/3)
        }
        
        
    }
    
    /// mark: 闪光灯
    @objc func toLight(){
        self.navigationController?.pushViewController(LightController(), animated: true)
    }
    
    func createBtn(_ title:String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        
        return btn
    }

    
    func test(){
        let ace = Rank.four
        print(ace)
        let aceRawValue = ace.rawValue
        print(aceRawValue)
        
//        let tooBig:Int8 = Int8.max + 1
        let w: Int16 = 2_000
    }
}



enum Rank: Int {
    case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king

        func simpleDescription() -> String {
            switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
            }
        }
}
