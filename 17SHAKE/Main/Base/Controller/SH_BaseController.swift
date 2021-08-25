//
//  SH_BaseController.swift
//  
//
//  Created by Yehua Gao on 2020/5/17.
//

import UIKit

class SH_BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialView()
        
    }
    
    func initialView(){
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isTranslucent = false
    }

}
