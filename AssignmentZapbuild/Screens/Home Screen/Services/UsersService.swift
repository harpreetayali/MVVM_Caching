//
//  UsersService.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 17/01/24.
//

import Combine

protocol UsersServiceProtocol{
    func getUsers() -> AnyPublisher<Users,Error>
}

class UsersService: UsersServiceProtocol {
    func getUsers() -> AnyPublisher<Users, Error> {
        return APIService.shared.sendRequest(endPoint: APIEndpoint.usersList.url, method: .get, type: Users.self)
    }
}
