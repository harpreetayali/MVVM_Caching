//
//  UserDetailViewModel.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI
import Combine

 class UserDetailViewModel: ObservableObject {
     @Published var user:UsersModel?
     @Published var isLoading:Bool = false
     
     private var cancellabels = Set<AnyCancellable>()
     private let repository:UserDetailRepositoryProtocol
     
     init(userId:Int,repository:UserDetailRepositoryProtocol) {
         self.repository = repository
         getUserDetail(userId: userId)
     }
     func getUserDetail(userId:Int){
        isLoading = true
         repository.getUsers(userId: userId).receive(on: DispatchQueue.main)
             .sink { [weak self] completion in
                 guard let self else {return}
                 switch completion{
                 case .finished:
                     break
                 case .failure(let error):
                     self.isLoading = false
                     print("Failed to fetch user detail \(error)")
                 }
         } receiveValue: { [weak self] model in
             guard let self else { return }
             self.isLoading = false
             self.user = model
         }.store(in: &cancellabels)

     }
}
