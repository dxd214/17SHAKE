//
//  SH_ProfileController.swift
//  17SHAKE
//
//  Created by gyh on 2019/12/10.
//  Copyright © 2019 com.berman.www. All rights reserved.
//

import UIKit
import SnapKit

class SH_ProfileController: SH_BaseController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    var contents = [["title":"登录","cls":"SHLoginController"],
                    ["title":"关于","cls":"SH_AboutController"],
                    ["title":"设置","cls":"SH_SettingController"],
                    ["title":"百宝箱","cls":"SH_TreasureBoxController"]]
    let cellIdentifier = "UITableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.setupView()
        
        test()
    }
    
    func test(){
//        print(SHUser.sharedUser.test())
//        var jack: SPerson? = SPerson(personName: "Jack")
//        jack!.printName()
//        jack?.loadBigData()
//        jack = nil
        let room = ClosureRoom()
        room.test()
//        room.isKind(of: GCDRoom.self)
        
        let kvoRoom = KVORoom()
        kvoRoom.test()
    }
    
    func setupView(){
        self.navigationItem.title = sh_tab_profile.localizedString
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.top.bottom.left.right.equalTo(self.view)
        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if (cell == nil){
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        cell?.textLabel?.text = self.contents[indexPath.row]["title"]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(SHLoginController(), animated: true)
            
        case 1:
            self.navigationController?.pushViewController(SH_AboutController(), animated: true)
            
        case 2:
            self.navigationController?.pushViewController(SH_SettingController(), animated: true)
            
        case 3:
            let treasureVC = SH_TreasureBoxController()
            treasureVC.selectedIndex = 1
            self.navigationController?.pushViewController(treasureVC, animated: true)
            
        default:
            break;
        }
    }
}
