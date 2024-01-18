//
//  UserDetailRepository.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 17/01/24.
//

import Combine

protocol UserDetailRepositoryProtocol{
    func getUsers(userId:Int) -> AnyPublisher<UsersModel,Error>
}

class UserDetailRepository: UserDetailRepositoryProtocol {
    let userDetailService:UserDetailServiceProtocol
    let userDetailOfflineService:UserDetailOfflineServiceProtocol
    
    init(usersService: UserDetailServiceProtocol, usersOfflineService: UserDetailOfflineServiceProtocol) {
        self.userDetailService = usersService
        self.userDetailOfflineService = usersOfflineService
    }
    
    func getUsers(userId:Int) -> AnyPublisher<UsersModel, Error> {
        userDetailService.getUsers(userId: userId)
            .map { user in
                return user
            }
            .catch { error -> AnyPublisher<UsersModel,Error> in
                return self.userDetailOfflineService.getUserDetail(userId: userId)
            }
            .eraseToAnyPublisher()
        
    }
}
