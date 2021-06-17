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
    
    lazy var captureSession = AVCaptureSession()
    lazy var captureDevice = AVCaptureDevice.default(for: .video)
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupView()
        
    }
    
    @objc func startCount(){
        count += 1
        print(count)
        
        guard let _ = (captureDevice?.isTorchModeSupported(AVCaptureDevice.TorchMode.on) ?? false) else {
            return
        }
        
        if captureDevice?.torchMode == .off {
            captureDevice?.torchMode = .on
            if #available(iOS 11.0, *){
                
            }else {
                
            }
            captureDevice?.flashMode = .on
            
        }else {
            captureDevice?.torchMode = .off
            captureDevice?.flashMode = .off
        }
        
        captureDevice?.unlockForConfiguration()
        captureSession.commitConfiguration()
        
        if captureDevice?.torchMode == .off {
            captureSession.startRunning()
        }else {
            captureSession.stopRunning()
        }
        
    }
    
    func setupView(){
        
        let lightSwitch = UISwitch()
        self.view.addSubview(lightSwitch)
        lightSwitch.addTarget(self, action: #selector(switchLight(_:)), for: .valueChanged)
        
        lightSwitch.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.view)
        }
        
        self.timer.fireDate = Date.distantFuture
    }
    
    @objc func switchLight(_ sender:UISwitch){
        sender.isOn ? openFlash():closeFlash()
    }
    
    func openFlash(){
        timer.fireDate = Date.distantPast
    }
    
    func closeFlash(){
        timer.fireDate = Date.distantFuture
    }
    
    

}
