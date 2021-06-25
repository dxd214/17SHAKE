//
//  SH_CommentController.swift
//  17SHAKE
//
//  Created by gyh on 2019/12/10.
//  Copyright © 2019 com.berman.www. All rights reserved.
//

import UIKit

class SH_CommentController: SH_BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupView()
    }
    
    func setupView(){
        self.navigationItem.title = sh_tab_comment.localizedString
    }
    
}
