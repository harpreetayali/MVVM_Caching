//
//  ContentView.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI
import CoreData
import GoogleMaps

struct HomeScreen: View {
    @StateObject var viewModel = HomeScreenViewModel(
                                    repository: UsersRepository(usersService: UsersService(),
                                                                usersOfflineService: UsersOfflineService(
                                                                    persistentContainer: PersistenceController.shared.container)))
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                ZStack{
                    VStack{
                        
                        // Google map view
                        MapView(viewModel: MapViewModel(markers: $viewModel.markers, selectedMarker: $viewModel.selectedMarker))
                            .frame(height: geometry.size.height * viewModel.percent)
                            .animation(.spring, value:viewModel.percent)
                        
                        // Handle bar for swipe
                        HStack(alignment: .center) {
                            Rectangle()
                                .frame(width: 25, height: 4, alignment: .center)
                                .cornerRadius(10)
                                .padding(.vertical, 8)
                        }
                        .frame(width: geometry.size.width, height: 20, alignment: .center)
                        .background(.white)
                        .gesture(
                            DragGesture().onChanged { value in
                                
                            }.onEnded { value in
                                viewModel.expandList.toggle()
                                viewModel.percent = viewModel.expandList ? 0.1 : 0.4
                            }
                        )
                        
                        // Users List
                        List {
                            ForEach(viewModel.usersList) { user in
                                NavigationLink {
                                    UserDetail(userId: user.id ?? 0)
                                } label: {
                                    UserCell(user: user) { userModel in
                                        if let latStr = userModel.address?.geo?.lat,let lngStr = userModel.address?.geo?.lng
                                            ,let lat = Double(latStr),let lng = Double(lngStr){
                                            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
                                            marker.snippet = userModel.name ?? ""
                                            viewModel.selectedMarker = marker
                                        }
                                        viewModel.expandList = false
                                    }
                                    
                                }
                                
                            }
                        }.frame(maxWidth: .infinity)
                            .task {
                                viewModel.selectedMarker = nil
                                viewModel.getUsersList()
                            }
                    }
                    
                    if viewModel.isLoading{
                        LoadingView()
                    }
                    
                }
            }
            .navigationTitle("Users")
        }
        
    }
}
#Preview {
    HomeScreen()
}
