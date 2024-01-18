//
//  APIEndpoints.swift
//  Avengers
//
//  Created by Harpreet Singh on 06/10/23.
//

import Foundation

enum APIEndpoint{
    
    private var baseUrl: String{
       return "https://jsonplaceholder.typicode.com/"
    }
    
    case usersList
    case userDetail(Int)
    
    var url:String{
        switch self {
        case .usersList:
            return "\(baseUrl)users"
        case .userDetail(let userId):
            return "\(baseUrl)users/\(userId)"
        }
    }
}
