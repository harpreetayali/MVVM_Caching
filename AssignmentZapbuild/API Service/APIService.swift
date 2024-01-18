//
//  APIService.swift
//  Avengers
//
//  Created by Harpreet Singh on 05/10/23.
//

import Foundation
import Alamofire
import Combine

class APIService {
    
    static let shared = APIService()
    
    func sendRequest<T:Decodable>(endPoint:String,
                                  method:HTTPMethod,
                                  encoding:URLEncoding = URLEncoding.default,
                                  params:[String:Any]? = nil,
                                  header:HTTPHeaders? = nil,
                                  type:T.Type) -> AnyPublisher<T,Error>{
        return Future<T,Error> { promise in
            
            DispatchQueue.global().async {
                let request = AF.request(endPoint, method: method, parameters: params,encoding:encoding,headers: header)
                request.responseDecodable(of:T.self) {
                    response in
                    switch response.result{
                    case .failure(let error):
                        promise(.failure(error))
                    case .success(let data):
                        promise(.success(data))
                    }
                }
                
            }
        }.eraseToAnyPublisher()
    }
}
