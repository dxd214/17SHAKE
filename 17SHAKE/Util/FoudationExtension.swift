//
//  Extension.swift
//  17SHAKE
//
//  Created by Yehua Gao on 2020/5/17.
//  Copyright © 2020 com.17shake. All rights reserved.
//

import UIKit

extension String {
    var localizedString : String{
        get {
            return NSLocalizedString(self, comment: self)
        }
    }
    
    func urlEncode() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    func lowercased() -> String {
//        self.lowercased()
        return self
    }
}

extension String {
    func originalLowerCased() -> String {
        return self.lowercased()
    }
}
