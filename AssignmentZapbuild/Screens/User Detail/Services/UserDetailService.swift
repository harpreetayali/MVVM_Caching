//
//  UserDetailService.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 17/01/24.
//

import Combine

protocol UserDetailServiceProtocol{
    func getUsers(userId:Int) -> AnyPublisher<UsersModel,Error>
}

class UserDetailService: UserDetailServiceProtocol {
    func getUsers(userId:Int) -> AnyPublisher<UsersModel, Error> {
        return APIService.shared.sendRequest(endPoint: APIEndpoint.userDetail(userId).url, method: .get, type: UsersModel.self)
    }
}
