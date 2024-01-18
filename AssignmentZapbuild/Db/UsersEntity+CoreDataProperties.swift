//
//  UsersEntity+CoreDataProperties.swift
//  
//
//  Created by Harpreet Singh on 17/01/24.
//
//

import Foundation
import CoreData


extension UsersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersEntity> {
        return NSFetchRequest<UsersEntity>(entityName: "UsersEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var email: String?
    @NSManaged public var username: String?
    @NSManaged public var address: String?
    @NSManaged public var companyName: String?
    @NSManaged public var companyInfo: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}
