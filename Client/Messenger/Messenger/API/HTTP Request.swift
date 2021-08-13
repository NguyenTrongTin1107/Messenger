//
//  HTTP Request.swift
//  Messenger
//
//  Created by Trọng Tín on 26/07/2021.
//

import Foundation
import Alamofire

class HttpRequest {
    func login (user: User, complete: @escaping (Int, User?)->()) {
        let url = BaseURL + "/login"
        AF.request(url, method: .post, parameters: user, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let user = try! JSONDecoder().decode(User.self, from: final)
                            complete(result, user)
                        }
                    }
                case .failure(let error):
                    debugPrint("Request failed with error: \(error)")
                }
            }
    }
    
    func register (user: User, complete: @escaping (Int, User?)->()) {
        let url = BaseURL + "/register"
        AF.request(url, method: .post, parameters: user, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let user = try! JSONDecoder().decode(User.self, from: final)
                            complete(result, user)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
    
    func getAllUsersWithConservation (complete: @escaping (Int, [User]?)->()) {
        let url = BaseURL + "/conservation/get_users"
        
        let params: Parameters = [
            "id": Default.user._id!
        ]
        
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let listUser = try! JSONDecoder().decode([User].self, from: final)
                            complete(result, listUser)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
    
    func getPreviousMessages(toId: String?, complete: @escaping (Int, [String]?)->()) {
        let url = BaseURL + "/conservation/get_messages"
        let params: Parameters = [
            "ids": [Default.user._id!, toId!]
        ]
        
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let messages = try! JSONDecoder().decode([String].self, from: final)
                            complete(result, messages)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
}
