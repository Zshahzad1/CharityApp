//
//  ApiManager.swift
//  CharityApp
//
//  Created by Admin on 15/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ApiManager{
    
    var baseURL = "http://api.chariapp.com/public/users/";
    
    func Login(email: String, password: String, completion: @escaping ((_ data: NSDictionary) -> Void))
    {
        let url = baseURL+"login?email=\(email)&password=\(password)"
        let urlComponent = URLComponents(string: url)!
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "POST"
        let bodyData = "email=\(email)&password=\(password)"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        //Now use this URLRequest with Alamofire to make request
//        Alamofire.request(request).validate().responseJSON { response in
//             let json = JSON(response.data)
//            switch response.result {
//            case .success(let data):
//                let jsonarray = json as NSDictionary
//                completion(jsonarray)
//            case .failure(let error):
//                completion(nil)
//            }
//        }
        
    }
    
}
