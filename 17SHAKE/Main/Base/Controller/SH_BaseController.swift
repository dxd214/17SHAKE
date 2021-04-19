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

        // Do any additional setup after loading the view.
        
        self.initialView()
        
    }
    
    func initialView(){
//        self.navigationItem.title = "Home"
        self.view.backgroundColor = .white
    }

}
