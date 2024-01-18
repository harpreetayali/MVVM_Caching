//
//  HomeScreenViewModel.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI
import GoogleMaps
import Combine

class HomeScreenViewModel: ObservableObject {
    
    @Published var markers: [GMSMarker] = []
    @Published var usersList:Users = []
    @Published var expandList: Bool = false
    @Published var selectedMarker:GMSMarker?
    @Published var percent: CGFloat = 0.4
    @Published var isLoading:Bool = false
    
    private let repository:UsersRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: UsersRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUsersList(){
        isLoading = true
        repository.getUsers().receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.isLoading = false
                    print("Failed to fetch Users --> \(error)")
                    
                }
            } receiveValue: { users in
                self.usersList = users
                self.updateMarkers()
            }.store(in: &cancellables)

    }
    
    private func updateMarkers(){
        
        usersList.forEach { model in
            autoreleasepool {
                if let latStr = model.address?.geo?.lat,
                   let lngStr = model.address?.geo?.lng,
                    let lat = Double(latStr),let lng = Double(lngStr){
                    
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                    markers.append(marker)
                }
            }
        }
        self.isLoading = false
    }
}
