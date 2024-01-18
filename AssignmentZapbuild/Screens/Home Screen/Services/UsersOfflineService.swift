//
//  UsersOfflineServiceProtocol.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 17/01/24.
//

import Combine
import CoreData
import SwiftUI

protocol UsersOfflineServiceProtocol{
    func getUsers() -> AnyPublisher<Users,Error>
    func save(users:Users)
}


class UsersOfflineService:UsersOfflineServiceProtocol{
    let persistentContainer:NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getUsers() -> AnyPublisher<Users, Error> {
        let request:NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
        let context = persistentContainer.viewContext
        
        return Future<Users,Error> { promise in
            do{
                let usersEntities = try context.fetch(request)
                let users = usersEntities.map { UsersModel(entity: $0)}
                if users.isEmpty{
                    if let path = Bundle.main.path(forResource: "data", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path))
                            let users = try JSONDecoder().decode(Users.self, from: data)
                            promise(.success(users))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }else{
                    promise(.success(users))
                }
            }catch{
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func save(users: Users) {
        let context = PersistenceController.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                let request: NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
                let existingUserEntities = try context.fetch(request)
                let existingUserIds = existingUserEntities.compactMap { Int($0.id) }
                
                users.forEach { user in
                    if let id = user.id,!existingUserIds.contains(id) {
                        let userEntity = UsersEntity(context: context)
                        userEntity.id = Int32(user.id ?? 0)
                        userEntity.name = user.name
                        userEntity.username = user.username
                        userEntity.email = user.email
                        userEntity.companyInfo = user.company?.catchPhrase
                        userEntity.companyName = user.company?.name
                        userEntity.latitude = user.address?.geo?.lat
                        userEntity.longitude = user.address?.geo?.lng
                    }
                }
                try context.save()
            } catch {
                print("Failed to save Users to core data: \(error)")
            }
        }
    }
}
