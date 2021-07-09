//
//  SHLoginController.swift
//  17SHAKE
//
//  Created by gyh on 2021/7/9.
//

import RxSwift
import SnapKit

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class SHLoginController: SH_BaseController {
    
    // MARK: ------ 生命周期 ------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubviews()
        
        setupLogic()
    }
    
    // MARK: ------ 业务逻辑 ------
    func setupLogic() {
        let isUserNameValid = userNameTxf.rx.text.orEmpty.map { $0.count >= minimalUsernameLength }.share(replay: 1)
        isUserNameValid.bind(to: textLabel.rx.isHidden).disposed(by: disposeBag)
        
        let isPwdTxfValid = pwdTxf.rx.text.orEmpty.map { $0.count > minimalPasswordLength }.share(replay: 1)
        
        let commitable = Observable.combineLatest(isUserNameValid, isPwdTxfValid) { $0 && $1 }.share(replay: 1)
        
        commitable.bind(to: commitBtn.rx.isEnabled).disposed(by: disposeBag)
        
        commitBtn.rx.tap.subscribe(onNext:{ [weak self] _ in
            let userName = self?.userNameTxf.text ?? ""
            print("\(userName)----开始登录")
        }).disposed(by: disposeBag)

    }
    
    // MARK: ------ 页面布局 ------
    func layoutSubviews() {
        self.userNameTxf.snp.makeConstraints { (maker:ConstraintMaker) in
            maker.centerX.equalTo(self.view)
            maker.top.equalTo(self.view).offset(80)
            maker.height.equalTo(40)
            maker.width.equalTo(200)
        }
        
        self.pwdTxf.snp.makeConstraints { (maker) in
            maker.centerX.width.height.equalTo(self.userNameTxf)
            maker.top.equalTo(self.userNameTxf.snp_bottomMargin).offset(20)
        }
        
        self.textLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.pwdTxf.snp_bottomMargin).offset(10)
            maker.width.centerX.height.equalTo(self.pwdTxf)
        }
        
        self.commitBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.textLabel.snp_bottomMargin).offset(30)
            maker.width.centerX.height.equalTo(self.textLabel)
        }
    }
    
    // MARK: ------ 属性代码 ------
    /// 用户名输入框
    fileprivate lazy var userNameTxf:UITextField = {
       var textF = UITextField()
        textF.borderStyle = .roundedRect
        textF.placeholder = "请输入用户名"
        textF.textAlignment = .center
        self.view.addSubview(textF)
        return textF
    }()
    
    /// 密码输入框
    fileprivate lazy var pwdTxf:UITextField = {
       var textF = UITextField()
        textF.borderStyle = .roundedRect
        textF.placeholder = "请输入密码"
        textF.textAlignment = .center
        textF.isSecureTextEntry = true
        self.view.addSubview(textF)
        return textF
    }()
    
    /// 提示label
    fileprivate lazy var textLabel:UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "输入有效"
        label.textAlignment = .center
        self.view.addSubview(label)
        return label
    }()
    
    /// 点击按钮
    fileprivate lazy var commitBtn:UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 20
        btn.setTitle("提交", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        self.view.addSubview(btn)
        return btn
    }()
    
    /// 回收
    fileprivate lazy var disposeBag:DisposeBag = {
        let bag = DisposeBag()
        return bag
    }()

}
