//
//  BaseRequest.swift
//  17SHAKE
//
//  Created by Yehua Gao on 2020/5/17.
//  Copyright © 2020 com.17shake. All rights reserved.
//

//import Moya

enum BaseRequest {
    case categoriesList(categoryType: String)
    case other
}


//extension BaseRequest: TargetType {
//    
//    var baseURL: URL {
//        return URL(string: "https://gank.io/api/v2/")!
//    }
//    
//    var path: String {
//        switch self {
//        case .categoriesList:
//            return "categories/Article"
//        default:
//            return ""
//        }
//    }
//    
//    var method: Method {
//        return .get
//    }
//    
//    var sampleData: Data {
//        return "{}".data(using: String.Encoding.utf8)!
//    }
//    
//    var task: Task {
//        return .requestPlain
//    }
//    
//    var headers: [String : String]? {
//        return nil
//    }
//}

class HomeCategoryRequest {
//    func requestCategoryList(){
//                let provide = MoyaProvider<BaseRequest>()
//        provide.request(<#T##target: BaseRequest##BaseRequest#>) { (<#Result<Response, MoyaError>#>) in
//            <#code#>
//        }
//    }
}


