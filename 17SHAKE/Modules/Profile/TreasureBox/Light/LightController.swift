//
//  LightController.swift
//  17SHAKE
//
//  Created by gyh on 2021/6/15.
//

import UIKit
import AVFoundation

class LightController: SH_BaseController {
    
    lazy var timer:Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startCount), userInfo: nil, repeats: true)
        
        return timer
    }()
    
    var captureSession = AVCaptureSession()
    var captureDevice = AVCaptureDevice.default(for: .video)
    
    var lightness: Float = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.bwm_showTitle("灯光准备就绪", to: self.view, hideAfter: 3)
 
        setupView()
        
        var tup = [Int]()
        tup.append(10)
        print(type(of: tup))
        
        var dic = [String:Any]()
        dic["h"] = "Hello"
        
    }
    
    // mark: 手电筒闪烁（闪光灯）
    @objc func startCount(){
        do {
            try captureDevice?.lockForConfiguration()
            // 设置手电筒亮度
            try captureDevice?.setTorchModeOn(level: lightness)
        } catch  {
            MBProgressHUD.bwm_showTitle("lock异常", to: self.view, hideAfter: 3)
        }
        
        if ((captureDevice?.hasFlash) != nil) {
            if captureDevice?.torchMode == .off {
                turnOnCaptureDevice()
            }else {
                turnOffCaptureDevice()
            }
        }else {
            MBProgressHUD.bwm_showTitle("当前设备不支持手电筒", to: self.view, hideAfter: 3)
        }
    }
    
    // MARK: 打开手电筒
    func turnOnCaptureDevice(){
        if captureDevice?.torchMode == .off {
            captureDevice?.torchMode = .on
            captureDevice?.unlockForConfiguration()
        }
    }
    
    // MARK: 关闭手电筒
    func turnOffCaptureDevice(){
        if captureDevice?.torchMode == .on {
            captureDevice?.torchMode = .off
            captureDevice?.unlockForConfiguration()
        }
    }
    
    func setupView(){
        
        let lightLabel = UILabel()
        self.view.addSubview(lightLabel)
        lightLabel.text = "闪光灯开关："
        
        lightLabel.snp.makeConstraints { (maker) in
            maker.top.left.equalTo(30)
            maker.width.equalTo(180)
            maker.height.equalTo(30)
        }
        
        let lightSwitch = UISwitch()
        self.view.addSubview(lightSwitch)
        lightSwitch.addTarget(self, action: #selector(switchLight(_:)), for: .valueChanged)
        
        lightSwitch.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(lightLabel)
            maker.width.equalTo(100)
            maker.left.equalTo(lightLabel.snp_rightMargin).offset(10)
        }
        
        let lightnessLabel = UILabel()
        self.view.addSubview(lightnessLabel)
        lightnessLabel.text = "亮度调整："
        
        lightnessLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(lightLabel.snp_bottomMargin).offset(20)
            maker.left.height.width.equalTo(lightLabel)
        }
        
        let lightnessSlider = UISlider()
        lightnessSlider.value = lightness
        self.view.addSubview(lightnessSlider)
        lightnessSlider.minimumValue = 0.1
        lightnessSlider.maximumValue = 1
        lightnessSlider.addTarget(self, action: #selector(changeLightness(_:)), for: .valueChanged)
        lightnessSlider.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(lightnessLabel)
            maker.left.width.equalTo(lightSwitch)
        }
    }
    
    @objc func switchLight(_ sender:UISwitch){
        if (sender.isOn){
            timer.fireDate = Date.distantPast
        }else {
            timer.fireDate = Date.distantFuture
            turnOffCaptureDevice()
        }
    }
    
    @objc func changeLightness(_ sender:UISlider){
        lightness = sender.value
    }
}
