//
//  UsersModel.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import Foundation

// MARK: - WelcomeElement
struct UsersModel: Codable,Identifiable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let company: Company?
    
    init(entity:UsersEntity) {
        id = Int(entity.id)
        name = entity.name
        username = entity.username
        email = entity.email
        let geo = Geo(lat: entity.latitude, lng: entity.longitude)
        address = Address(geo: geo)
        company = Company(name: entity.companyName, catchPhrase: entity.companyInfo, bs: "")
    }
}

// MARK: - Address
struct Address: Codable {
    let geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String?
}

typealias Users = [UsersModel]



//MARK: Used below data while UI implementation without core data

//struct MockData{
//    static let userModel = UsersModel(id: 1,
//                                      name: "Harpreet",
//                                      username: "harpreetSingh",
//                                      email: "singhsharpreet3@gmail.com",
//                                      address: Address(street: "", suite: "", city: "Ludhiana", zipcode: "142027", geo: Geo(lat: "30.8921896", lng: "75.7536185")), phone: "7837276461", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
//    static let userModel1 = UsersModel(id: 2,
//                                      name: "Harpreet",
//                                      username: "harpreetSingh",
//                                      email: "singhsharpreet3@gmail.com",
//                                      address: Address(street: "", suite: "", city: "Ludhiana", zipcode: "142027", geo: Geo(lat: "30.8921896", lng: "75.7536185")), phone: "7837276461", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
//    
//    static let userModel2 = UsersModel(id: 3,
//                                      name: "Harpreet",
//                                      username: "harpreetSingh",
//                                      email: "singhsharpreet3@gmail.com",
//                                      address: Address(street: "", suite: "", city: "Ludhiana", zipcode: "142027", geo: Geo(lat: "30.8921896", lng: "75.7536185")), phone: "7837276461", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
//    
//    static let userModel3 = UsersModel(id: 4,
//                                      name: "Harpreet",
//                                      username: "harpreetSingh",
//                                      email: "singhsharpreet3@gmail.com",
//                                      address: Address(street: "", suite: "", city: "Ludhiana", zipcode: "142027", geo: Geo(lat: "30.8921896", lng: "75.7536185")), phone: "7837276461", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
//    static let userModel4 = UsersModel(id: 4,
//                                      name: "Harpreet",
//                                      username: "harpreetSingh",
//                                      email: "singhsharpreet3@gmail.com",
//                                      address: Address(street: "", suite: "", city: "Ludhiana", zipcode: "142027", geo: Geo(lat: "30.8921896", lng: "75.7536185")), phone: "7837276461", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
//    
//    static let users = [userModel, userModel1, userModel2, userModel3, userModel4]
//}
