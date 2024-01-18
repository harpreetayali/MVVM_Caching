//
//  UserDetailOfflineService.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 17/01/24.
//

import Combine
import CoreData
import SwiftUI

protocol UserDetailOfflineServiceProtocol{
    func getUserDetail(userId:Int) -> AnyPublisher<UsersModel,Error>
}


class UserDetailOfflineService:UserDetailOfflineServiceProtocol{
    let persistentContainer:NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getUserDetail(userId:Int) -> AnyPublisher<UsersModel, Error> {
        let request:NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", userId)
        request.predicate = predicate
        let context = persistentContainer.viewContext
        
        return Future<UsersModel,Error> { promise in
            do{
                let usersEntities = try context.fetch(request)
                let users = usersEntities.map { UsersModel(entity: $0)}
                if users.isEmpty{
                    if let path = Bundle.main.path(forResource: "data", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path))
                            let users = try JSONDecoder().decode(Users.self, from: data)
                            let filteredUsers = users.filter{ $0.id == userId }
                            promise(.success(filteredUsers[0]))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                else{
                    promise(.success(users[0]))
                }
            }catch{
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
