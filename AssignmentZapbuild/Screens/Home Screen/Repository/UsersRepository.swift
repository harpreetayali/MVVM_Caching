//
//  UsersRepository.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 17/01/24.
//

import Foundation
import Combine

protocol UsersRepositoryProtocol{
    func getUsers() -> AnyPublisher<Users,Error>
}

class UsersRepository: UsersRepositoryProtocol {
    let usersService:UsersServiceProtocol
    let usersOfflineService:UsersOfflineServiceProtocol
    
    init(usersService: UsersServiceProtocol, usersOfflineService: UsersOfflineServiceProtocol) {
        self.usersService = usersService
        self.usersOfflineService = usersOfflineService
    }
    
    func getUsers() -> AnyPublisher<Users, Error> {
        usersService.getUsers()
            .map {[weak self] users in
                self?.usersOfflineService.save(users: users)
                return users
            }
            .catch { error -> AnyPublisher<Users,Error> in
                return self.usersOfflineService.getUsers()
            }.eraseToAnyPublisher()
    }
}
