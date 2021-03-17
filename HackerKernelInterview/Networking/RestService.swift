//
//  RestService.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import Foundation
import Alamofire

enum Methods: String {
    case post = "POST"
    case get = "GET"
}

struct RestServices {
    
    public static func serviceCall(url:String, method:HTTPMethod, parameters:Parameters?, isLoaded:Bool, title:String, message:String, vc:UIViewController, success: @escaping(Data)->Void, failure:@escaping(Error)->Void){
        
        if isLoaded {
            Indicator.shared().showIndicator(withTitle: title, and: message, vc: vc)
        }
        
        let headers:HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) in
            
            Indicator.shared().hideIndicator(vc: vc)
            
            switch responseData.result{
            case .success(_):
                success(responseData.data!)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
