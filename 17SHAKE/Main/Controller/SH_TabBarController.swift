//
//  SH_TabBarController.swift
//  17SHAKE
//
//  Created by gyh on 2019/12/10.
//  Copyright © 2019 com.berman.www. All rights reserved.
//

import UIKit

class SH_TabBarController: UITabBarController {
    
    //    var childControllers = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = self.setUpChildController(SH_HomeController(), title: sh_tab_home.localizedString, norIcon: "bm_home_nor", selIcon: "bm_home_sel")
        let discover = self.setUpChildController(SH_DiscoverController(), title: sh_tab_discover.localizedString, norIcon: "bm_shop_nor", selIcon: "bm_shop_sel")
        let comment = self.setUpChildController(SH_CommentController(), title: sh_tab_comment.localizedString, norIcon: "bm_order_nor", selIcon: "bm_order_sel")
        let profile = self.setUpChildController(SH_ProfileController(), title: sh_tab_profile.localizedString, norIcon: "bm_profile_nor", selIcon: "bm_profile_sel")
        self.viewControllers = [home, discover, comment, profile]
    }
    
    func setUpChildController(_ controller:UIViewController, title: String, norIcon:String, selIcon:String) -> SH_NavigationController{
        let navigationController = SH_NavigationController(rootViewController: controller);
        navigationController.tabBarItem.title = title;
        navigationController.tabBarItem.image = UIImage(named: norIcon)?.withRenderingMode(.alwaysOriginal)
        navigationController.tabBarItem.selectedImage = UIImage(named: selIcon)?.withRenderingMode(.alwaysOriginal)
        navigationController.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3)
        
        let norAttribute = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]
        
        let selAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]
        
        navigationController.tabBarItem.setTitleTextAttributes(norAttribute, for: .normal)
        navigationController.tabBarItem.setTitleTextAttributes(selAttribute, for: .selected)
        
        return navigationController;
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
